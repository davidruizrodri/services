require "#{Rails.root}/app/services/world_weather_online/api"
require "#{Rails.root}/app/services/redis_storable"

module WorldWeatherOnline
  class Base
    include RedisStorable

    DATA_SOURCE = Api

    attr_reader :place, :options

    def initialize(place, options = {})
      @place   = place
      @options = options.merge q: place.to_s
    end

    def measure!
      redis_store(redis_store_key) { request }
    end

    def retrieve
      redis_retrieve(redis_store_key, as: :hash) || {}
    end

  protected

    def request
      DATA_SOURCE.new(class_name, options).request
    end

    def class_name
      ActiveSupport::Inflector.demodulize(self.class).underscore.to_sym
    end

    def redis_store_key
      :"#{class_name}_#{place}_measure"
    end
  end
end
