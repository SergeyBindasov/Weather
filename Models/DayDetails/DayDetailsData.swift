//
//  DayDetailsData.swift
//  Weather
//
//  Created by Sergey on 23.05.2022.
//

import Foundation

struct DayDetailsData: Codable {
    var cnt: Int
    var list: [List]
    var city: City
}

struct City: Codable {
    var name: String
}




