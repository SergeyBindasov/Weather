//
//  MainViewController.swift
//  Weather
//
//  Created by Sergey on 04.03.2022.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

class MainViewController: UIViewController, WeatherManagerDelegate {
   
    
    var currentWeatherView = CurrentWeatherView()
    var network = WeatherNetworkManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view = currentWeatherView
        network.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.settings), style: .plain, target: self, action: #selector(settingsButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.location), style: .plain, target: self, action: #selector(loactionButtonPressed))
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blackText)
    
    }
}



// MARK: - Class Methods
extension MainViewController {
    
    func didUpdateWeather(_ weatherManager: WeatherNetworkManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.currentWeatherView.updateCurrentWeatherUI(with: weather)
        }
        
        
    }
    
    @objc func settingsButtonPressed() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc func loactionButtonPressed() {
        
    
        let alert = UIAlertController(title: "Добавить новый город", message: "", preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.placeholder = "Введите назавние"
            
        }
        
        let action = UIAlertAction(title: "Оk", style: .cancel) { action in
            guard let textfields = alert.textFields, let cityFromTF = textfields[0].text else { return }
    
            self.network.fetchWeatherBy(cityName: cityFromTF)
            self.dismiss(animated: true, completion: nil)
        }
        let decline = UIAlertAction(title: "Отмена", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(decline)
        present(alert, animated: true, completion: nil)
       
    }
    
 func setupLayout() {
     

   }
    
}





