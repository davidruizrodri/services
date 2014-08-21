require "#{Rails.root}/app/services/world_weather_online/base"

module WorldWeatherOnline
  class Weather < Base
    def retrieve_without_storage
      JSON.parse(request)
    end
  end
end
