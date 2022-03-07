//
//  MainViewController.swift
//  Weather
//
//  Created by Sergey on 04.03.2022.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.settings), style: .plain, target: self, action: #selector(settingsButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.location), style: .plain, target: self, action: #selector(loactionButtonPressed))
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blackText)
    
    }
}

extension MainViewController {
    
    @objc func settingsButtonPressed() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc func loactionButtonPressed() {
        
        let alert = UIAlertController(title: "Добавить новый город", message: "", preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.placeholder = "Введите назавние"
        }
        
        let action = UIAlertAction(title: "Оk", style: .cancel) { action in
            self.dismiss(animated: true, completion: nil)
        }
        let decline = UIAlertAction(title: "Отмена", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(decline)
        present(alert, animated: true, completion: nil)
       
    }
    
    
}
