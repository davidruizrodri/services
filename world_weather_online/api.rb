module WorldWeatherOnline
  class Api
    BASE_URL        = 'http://api.worldweatheronline.com/premium/v1'
    DEFAULT_KEY     = '-'
    DEFAULT_OPTIONS = { format: :json, key: DEFAULT_KEY }

    attr_reader :type, :options

    def initialize(type, options = {})
      @type    = type
      @options = DEFAULT_OPTIONS.merge options
    end

    def request
      Net::HTTP.get uri
    end

  private

    def uri
      URI(full_url)
    end

    def full_url
      [BASE_URL, '/#{type.to_s}.ashx?', options.to_param].join
    end
  end
end
