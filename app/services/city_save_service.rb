class CitySaveService
  def self.save( user, weather_data)
    city_query = City.new(
      name: weather_data[:city],
      user: user,
      temperature: weather_data[:temperature],
      lat: weather_data[:latitude],
      lon: weather_data[:longitude]
    )
    city_query.save
  end
end
