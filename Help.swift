//
//  MeasurementHelp.swift
//  Weather
//
//  Created by Sergey on 11.03.2022.
//

import Foundation
import UIKit

struct Help {
    
    var measurementFormatter = MeasurementFormatter()
    
    let formatter = DateFormatter()
    
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
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func dateStringFromUnixTime(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: date)
    }

    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 0.5
        
        view.layer.addSublayer(shapeLayer)
    }
}
