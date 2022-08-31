//
//  PollutionData.swift
//  Weather
//
//  Created by Sergey on 17.06.2022.
//

import Foundation

struct PollutionData: Codable {
    let list: [PollutionList]
}

struct PollutionList: Codable {
    let main: PollutionMain
}

struct PollutionMain: Codable {
    let aqi: Int
}




