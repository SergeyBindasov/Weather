//
//  OnbordingChecker.swift
//  Weather
//
//  Created by Sergey on 22.06.2022.
//

import Foundation

class OnbordingChecker {
    static let shared = OnbordingChecker()
    
    func isUserNew() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isUserNew")
    }
    
    func isNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isUserNew")
    }
}
