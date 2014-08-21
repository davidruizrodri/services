require "#{Rails.root}/app/services/world_weather_online/base"

module WorldWeatherOnline
  class Search < Base
    def results
      JSON.parse(request)['search_api'].try(:[], 'result') || []
    end
  end
end
