//
//  GeocodingRequest.swift
//  Weather
//
//  Created by Sergey on 29.04.2022.
//

import Foundation

class GeocodingRequest {
    
    var delegate: GeocodingManagerDelegate?
    
    var name: String = ""
    var lat: Double = 0
    var lon: Double = 0
    
    let url = "https://api.openweathermap.org/geo/1.0/direct?appid=15155ae34e7dd30a88d9313e93a5b681"
    
     func getCityCoordinatesBy(name: String)  {
        let urlString = "\(url)&q=\(name)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        /// ПОЧИТАТЬ
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encoded) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [self] data, response, error in
            if error != nil {
                print(error!)
            }
            if let safeData = data {
                if let coordinates = self.parseJson(with: safeData) {
                    delegate?.createNewCity(self, model: coordinates)
                }
            }
        }
        task.resume()
    }
    
    func parseJson(with safeData: Data) -> GeocodingModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let palces = try decoder.decode([GeocodingData].self, from: safeData)
            for place in palces {
                self.name = place.name
                self.lat = place.lat
                self.lon = place.lon
                _ = GeocodingModel(cityName: name, latitude: lat, longitude: lon)
            }
            return GeocodingModel(cityName: name, latitude: lat, longitude: lon)
        }
        catch {
            print(error)
            return nil
        }
    }
}
