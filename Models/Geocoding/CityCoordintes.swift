//
//  CityCoordintes.swift
//  Weather
//
//  Created by Sergey on 29.04.2022.
//

import Foundation
import RealmSwift

class CityCoordintes: Object {
    @objc dynamic var cityName: String = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
}
