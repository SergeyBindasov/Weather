//
//  ForecastWeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

class ForecastWeatherNetworkManager {
    
    let help = MeasurementHelp()
    
    var weekForecast: [ForecastWeatherModel] = []
    
    var date: String = ""
    var conditionID: Int = 0
    var precipitation: String = ""
    var description: String = ""
    var minTemp: String = ""
    var maxTemp: String = ""
    
    var onDataUpdate: ((_ data: [ForecastWeatherModel]) -> Void)?
    
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
                    if let w = self.parseHourJSON(weatherData: safeData) {
                        DispatchQueue.main.async {
                            self.onDataUpdate?(self.weekForecast)
                        }
                    }
                }
            }
            task.resume()
        }
    }

    func parseHourJSON(weatherData: Data) -> ForecastWeatherModel? {
       let decoder = JSONDecoder()
       decoder.keyDecodingStrategy = .convertFromSnakeCase
       do {
           let decodedData = try decoder.decode(ForecastWeatherData.self, from: weatherData)

           for day in decodedData.daily {
               self.date = help.dateStringFromUnixTime(unixTime: day.dt)
               self.precipitation = String(format: "%.0f", (day.pop * 100))
               self.minTemp = help.inCelcius(temp: day.temp.min)
               self.maxTemp = help.inCelcius(temp: day.temp.max)
               for wthr in day.weather {
                   self.conditionID = wthr.id
                   self.description = wthr.description
                   weekForecast.append(ForecastWeatherModel(date: date, conditionID: conditionID, precipitation: precipitation, description: description, minTemp: minTemp, maxTemp: maxTemp))
               }
           }
           return ForecastWeatherModel(date: date, conditionID: conditionID, precipitation: precipitation, description: description, minTemp: minTemp, maxTemp: maxTemp)
           
       } catch {
           print(error)
           return nil
       }
   }
}
