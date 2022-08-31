//
//  DayDetailsNetworkManager.swift
//  Weather
//
//  Created by Sergey on 23.05.2022.
//

import Foundation

class HourlyDetailsNetworkManager {
    
    var delegate: DayDetailsWeatherDelegate?
    
    var help = Help()
    
    let dayDetailsUrl = "https://api.openweathermap.org/data/2.5/forecast?&appid=15155ae34e7dd30a88d9313e93a5b681&lang=ru&cnt=8"
    
    func fetchWeatherBy(latitude: Double, longitude: Double) {
        let urlString = "\(help.setupString(url: dayDetailsUrl))&lat=\(latitude)&lon=\(longitude)"
       performDetailsRequest(with: urlString)
    }
    
    func performDetailsRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if let safeData = data {
                    if let weather = self.parseDetailsJSON(weatherData: safeData) {
                        
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateDayDetailsWeather(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseDetailsJSON(weatherData: Data) -> [DayDetailsModel]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            var models: [DayDetailsModel] = []
            let decodedData = try decoder.decode(DayDetailsData.self, from: weatherData)

            for list in decodedData.list {
                let model = DayDetailsModel(date: help.dateStringFromUnixTime(unixTime: list.dt),
                                            time: list.dt,
                                            currentTemp: list.main.temp,
                                            feelsLikeTemp: list.main.feelsLike,
                                            wind: String(list.wind.speed),
                                            cloud: String(list.clouds.all),
                                            humidity: String(list.main.humidity))
                models.append(model)
            }

            return models
        } catch {
            print(error)
            return nil
        }
    }
    
}
