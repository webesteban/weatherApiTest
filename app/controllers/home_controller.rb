class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:iata_code].present?
      @service = WeatherApiService.new()
      @weather_data = @service.get_weather_by_iata_code_cached(params[:iata_code])
      CitySaveService.save( current_user, @weather_data) if  @weather_data.present?
    end
    @last_cities = current_user.get_last_find_cities
  end
end
