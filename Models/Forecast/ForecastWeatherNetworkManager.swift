//
//  ForecastWeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

class ForecastWeatherNetworkManager {
    
    var delegate: ForecastWeatherDelegate?
    
    let help = Help()

    
    let forecastUrl = "https://api.openweathermap.org/data/2.5/onecall?&appid=15155ae34e7dd30a88d9313e93a5b681&units=metric&exclude=hourly,current,minutely,alerts&lang=ru"
    
    func fetchWeekWeather() {
        performDailyRequest(with: forecastUrl)
    }
    
    func fetchWeatherBy(latitude: Double, longitude: Double) {
        let urlString = "\(forecastUrl)&lat=\(latitude)&lon=\(longitude)"
        performDailyRequest(with: urlString)
    }
    
    func performDailyRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if let safeData = data {
                    if let weather = self.parseHourJSON(weatherData: safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateForecastWeather(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseHourJSON(weatherData: Data) -> [ForecastWeatherModel]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            var models = [ForecastWeatherModel]()
            let decodedData = try decoder.decode(ForecastWeatherData.self, from: weatherData)

            decodedData.daily.forEach { day in
            
                day.weather.forEach { weather in
                    
                    let model = ForecastWeatherModel(date: help.dateStringFromUnixTime(unixTime: day.dt),
                                                     conditionID: weather.id,
                                                     precipitation: String(format: "%.0f", (day.pop * 100)),
                                                     description: weather.description,
                                                     dayTemp: help.inCelcius(temp: day.temp.day),
                                                     nightTemp: help.inCelcius(temp: day.temp.night),
                                                     feelsLikeDay: help.inCelcius(temp: day.feelsLike.day),
                                                     feelsLikeNight: help.inCelcius(temp: day.feelsLike.night),
                                                     minTemp: help.inCelcius(temp: day.temp.min),
                                                     maxTemp: help.inCelcius(temp: day.temp.max),
                                                    wind: String(day.windSpeed),
                                                     uvi: String(day.uvi),
                                                     cloud: String(day.clouds),
                                                     sunrise: help.timeStringFromUnixTime(unixTime: day.sunrise),
                                                     moonrise: help.timeStringFromUnixTime(unixTime: day.moonrise),
                                                     sunset: help.timeStringFromUnixTime(unixTime: day.sunset),
                                                     moonset: help.timeStringFromUnixTime(unixTime: day.moonset),
                                                     sunDayTime: help.timeDifference(rise: day.sunrise, set: day.sunset),
                                                     nightTime: help.timeDifference(rise: day.moonrise, set: day.moonset),
                                                     timezone: decodedData.timezone
                                            
                    )

                    models.append(model)
                }
            }
            return models
        } catch {
            print(error)
            return nil
        }
    }
}
