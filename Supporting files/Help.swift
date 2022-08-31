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
    
    func inMilesPerHour(speed: Double) -> Double {
        let imperialSpeed = speed * 2.237
        let rounded = imperialSpeed.rounded()
        return rounded
    }
    
    func inMetersPerSecond(speed: Double) -> Double {
        let metricSpeed = speed / 2.237
        let rounded = metricSpeed.rounded()
        return rounded
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func timeDifference(rise: Double, set: Double) -> String {
        let sunriseTime = Date(timeIntervalSince1970: rise)
        let sunsetTime = Date(timeIntervalSince1970: set)
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute]
        dateFormatter.calendar?.locale = Locale(identifier: "ru_RU")
        dateFormatter.unitsStyle = .abbreviated
        if let difference = dateFormatter.string(from: sunriseTime, to: sunsetTime) {
            return difference
        }
        return ""
    }
    
    func dateStringFromUnixTime(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: date)
    }

    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView, opacity: Float, dash: Bool) {
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.opacity = opacity
        shapeLayer.lineWidth = 0.5
        if dash == true {
        shapeLayer.lineDashPattern = [4,4]
        }
        
        view.layer.addSublayer(shapeLayer)
    }
    
    
    func setupString(url: String) -> String {
        if UserDefaults.standard.bool(forKey: "temp") == true {
           return "\(url)&units=metric"
        } else {
            return "\(url)&units=imperial"
        }
    }
    
    
    
    
    
}
