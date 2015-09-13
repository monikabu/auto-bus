class Weather
  KELVIN_TO_CELSIUS_DIFF = 273.15

  def self.conditions(trail)
    response = parse(Excon.get("#{api_base_url}?q=#{trail.start_point_city}"))
    main = response['weather'].first['main']
    temperature = response['main'].first.second - KELVIN_TO_CELSIUS_DIFF
    evaluate_conditions(main, temperature)
  end

  def self.api_base_url
    "http://api.openweathermap.org/data/2.5/weather"
  end

  def self.parse(response)
    JSON.parse(response.body)
  end

  def self.evaluate_conditions(main, temperature)
    if main == "Rain" || temperature < 15
      I18n.t('weather.poor')
    else
      I18n.t('weather.good')
    end
  end
end
