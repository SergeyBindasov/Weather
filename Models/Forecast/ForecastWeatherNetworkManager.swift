//
//  ForecastWeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

class ForecastWeatherNetworkManager {
    
    var delegate: ForecastWeatherDelegate?
    
    let help = MeasurementHelp()
    
    var date: String = ""
    var conditionID: Int = 0
    var precipitation: String = ""
    var description: String = ""
    var minTemp: String = ""
    var maxTemp: String = ""
    
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
            var model = ForecastWeatherModel(date: date, conditionID: conditionID, precipitation: precipitation, description: description, minTemp: minTemp, maxTemp: maxTemp)
            decodedData.daily.forEach { day in
                self.date = help.dateStringFromUnixTime(unixTime: day.dt)
                self.precipitation = String(format: "%.0f", (day.pop * 100))
                self.minTemp = help.inCelcius(temp: day.temp.min)
                self.maxTemp = help.inCelcius(temp: day.temp.max)
                day.weather.forEach { weather in
                    self.conditionID = weather.id
                    self.description = weather.description
                    model.date = date
                    model.conditionID = conditionID
                    model.precipitation = precipitation
                    model.description = description
                    model.minTemp = minTemp
                    model.maxTemp = maxTemp
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
