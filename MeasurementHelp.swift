//
//  MeasurementHelp.swift
//  Weather
//
//  Created by Sergey on 11.03.2022.
//

import Foundation

struct MeasurementHelp {
    
    var measurementFormatter = MeasurementFormatter()
    
    func inCelcius(temp: Double) -> String {
        let measurement = Measurement(value: temp, unit: UnitTemperature.celsius)
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        return measurementFormatter.string(from: measurement)
    }
    
    func inFahrenheit(temp: Double) -> String {
        let measurement = Measurement(value: temp, unit: UnitTemperature.fahrenheit)
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        return measurementFormatter.string(from: measurement)
    }
    
        

    

    
}
