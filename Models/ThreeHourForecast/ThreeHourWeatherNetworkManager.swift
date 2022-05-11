//
//  ThreeHourWeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 12.04.2022.
//

import Foundation
import RealmSwift

class ThreeHourWeatherNetworkManager {
    
let help = MeasurementHelp()

var forecast: [ThreeHourWeatherModel] = []
    
var cities: Results<CityCoordintes>?

var temp: String = ""
var time: String = ""
var id: Int = 0
    
    var onDataUpdate: ((_ data: [ThreeHourWeatherModel]) -> Void)?
   
    
    let threeHourForecaetUrl = "https://api.openweathermap.org/data/2.5/forecast?&appid=15155ae34e7dd30a88d9313e93a5b681&lang=ru&cnt=12&units=metric"
    
     func fetchThreeHourWeatherBy(cityName: String) {
        let urlString = "\(threeHourForecaetUrl)&q=\(cityName)"
        performHourRequest(with: urlString)
       
    }
    
    func fetchWeatherBy(latitude: Double, longitude: Double) {
        let urlString = "\(threeHourForecaetUrl)&lat=\(latitude)&lon=\(longitude)"
        performHourRequest(with: urlString)
    }
    
    func performHourRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if let safeData = data {
                    if let _ = self.parseHourJSON(weatherData: safeData) {
                        DispatchQueue.main.async {
                            self.onDataUpdate?(self.forecast)

                        }
                    }
                }
            }
            task.resume()
        }
    }
    
     func parseHourJSON(weatherData: Data) -> ThreeHourWeatherModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(ThreeHourWeatherData.self, from: weatherData)

            for list in decodedData.list {

                self.time = help.timeStringFromUnixTime(unixTime: list.dt)
                self.temp = help.inCelcius(temp: list.main.temp)
                for w in list.weather {
                    self.id = w.id
                    forecast.append(ThreeHourWeatherModel(time: time, conditionID: id, temp: temp))
                }
            }
            
           return  ThreeHourWeatherModel(time: time, conditionID: id, temp: temp)
            
        } catch {
            print(error)
            return nil
        }
    }
    
}
