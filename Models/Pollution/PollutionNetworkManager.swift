//
//  PollutionNetworkManager.swift
//  Weather
//
//  Created by Sergey on 17.06.2022.
//

import Foundation

class PollutionNetworkManager {
    
    var delegate: PollutionManagerDelegate?
    
    var url = "https://api.openweathermap.org/data/2.5/air_pollution?&appid=15155ae34e7dd30a88d9313e93a5b681"
    
    func getPollution(latitude: Double, longitude: Double) {
        let urlString = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performPollutionRequest(with: urlString)
    }
    
    func performPollutionRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if let safeData = data {
                    if let pollution = self.parsePollutionJSON(pollutionData: safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdatePollution(self, weather: pollution)
                        }
                    }                        
                    }
                }
            task.resume()
            }
           
        }
    
    func parsePollutionJSON(pollutionData: Data) -> PollutionModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
          
            let decodedData = try decoder.decode(PollutionData.self, from: pollutionData)
            
            let condition = PollutionModel(aqiID: decodedData.list[0].main.aqi)
            return condition
        } catch {
            print(error)
            return nil
        }
    }
}

 
