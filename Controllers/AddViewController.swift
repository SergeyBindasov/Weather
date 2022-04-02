//
//  AddViewController.swift
//  Weather
//
//  Created by Sergey on 01.04.2022.
//

import Foundation
import UIKit

class AddViewController: UIViewController {
    
    var addCityView = AddCityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addCityView
    }
}
