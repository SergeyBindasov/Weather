//
//  PollutionModel.swift
//  Weather
//
//  Created by Sergey on 17.06.2022.
//

import Foundation

struct PollutionModel {
    let aqiID: Int
    
    var aqiName: String {
        switch aqiID {
        case 1:
            return "Хорошее"
        case 2:
            return "Приемлемое"
        case 3:
            return "Среднее"
        case 4:
            return "Плохое"
        case 5:
            return "Критическое"
        default:
            return "Среднее"
        }
    }
        
        var aqiColor: String {
            switch aqiID {
            case 1:
                return K.BrandColors.green
            case 2:
                return K.BrandColors.yellow
            case 3:
                return K.BrandColors.orangeDark
            case 4:
                return K.BrandColors.red
            case 5:
                return K.BrandColors.darkRed
            default:
                return K.BrandColors.lightBlue
    }
}
}
