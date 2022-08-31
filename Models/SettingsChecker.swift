//
//  SettingsChecker.swift
//  Weather
//
//  Created by Sergey on 29.06.2022.
//

import Foundation


class SettingsChecker {
    static let shared = SettingsChecker()
    
    private init() {}
    
    let defaults = UserDefaults.standard
    
    func isTempInC()  {
        // ture
        defaults.set(true, forKey: "temp")
    }
    
    func isTempInF() {
        // false
        defaults.set(false, forKey: "temp")
    }
    
    func isSpeedinMi() {
        //true
        defaults.set(true, forKey: "speed")
    }
    
    func isSpeedinKm() {
        //false
        defaults.set(false, forKey: "speed")
    }
    
    func isTwelve() {
        //true
        defaults.set(true, forKey: "time")
    }
    
    func isNotTwelve() {
        //false
        defaults.set(false, forKey: "time")
    }
    
    func notificationIsOn() {
        //true
        defaults.set(true, forKey: "notification")
    }
    
    func notificationIsOff() {
        //false
        defaults.set(false, forKey: "notification")
    }
    
}

