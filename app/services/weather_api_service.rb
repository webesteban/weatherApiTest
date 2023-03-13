require 'httparty'
require 'redis'

class WeatherApiService
  include HTTParty
  base_uri 'https://api.weatherapi.com/v1'

  def initialize()
    @options = { query: { key: "d3ed94b2121747c185075208231303" } }
    @redis = Redis.new(url: ENV['REDIS_URL'])
  end

  def get_weather_by_iata_code_cached(iata_code)
    cache_key = "weather_api_#{iata_code.upcase}"
    if @redis.exists?(cache_key)
      p "Ingresa a consultar la ciudad desde #{iata_code} la cache"
      weather_data = JSON.parse(@redis.get(cache_key))
    else
      weather_data = get_weather_by_iata_code(iata_code)
      @redis.set(cache_key, weather_data.to_json)
      @redis.expire(cache_key, 15.minutes.to_i)
    end
    {
      icon: weather_data.dig('current', 'condition', 'icon'),
      city: weather_data.dig('location', 'region'),
      temperature: weather_data.dig('current', 'temp_c'),
      latitude: weather_data.dig('location', 'lat'),
      longitude: weather_data.dig('location', 'lon')
    }
  end

  private
  def get_weather_by_iata_code(iata_code)
    p "Ingresa a consultar la ciudad desde #{iata_code} la API"
    self.class.get('/current.json',
                   @options.merge({ query: @options[:query].merge({ q: iata_code }) })).parsed_response
  end
end