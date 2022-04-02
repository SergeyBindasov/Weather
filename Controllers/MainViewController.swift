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

class MainViewController: UIViewController {
    
    var pageController: UIPageViewController!
    var pageControl = UIPageControl()
    
    var controllers: [UIViewController] = [CurrentWeatherViewController(cityName: "Moscow"), CurrentWeatherViewController(cityName: "Paris"), CurrentWeatherViewController(cityName: "Tokio")]
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageController()
        setupLayout()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.settings), style: .plain, target: self, action: #selector(settingsButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.location), style: .plain, target: self, action: #selector(loactionButtonPressed))
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blackText)
    
    }
}

//MARK: - UIPageViewControllerDelegate & UIPageViewControllerDataSource
extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let myPageViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = controllers.firstIndex(of: myPageViewController)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else { return nil }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else { return nil }
        }
        return nil
    }
    
    
}
    

// MARK: - Class Methods
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
            guard let textfields = alert.textFields, let cityFromTF = textfields[0].text else { return }
            let newCityVC = CurrentWeatherViewController(cityName: cityFromTF)
            self.controllers.append(newCityVC)
            self.updateDotsCount()
            // Тут должна быть потом модель сохранения города в базу
            self.dismiss(animated: true, completion: nil)
        }
        let decline = UIAlertAction(title: "Отмена", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(decline)
        present(alert, animated: true, completion: nil)
       
    }
    
func setupPageController() {
    updateDotsCount()
    pageControl.pageIndicatorTintColor = UIColor(named: K.BrandColors.lightText)
          pageControl.currentPageIndicatorTintColor = .black
          pageControl.hidesForSinglePage = true
    pageControl.currentPage = 0
    pageController = UIPageViewController(transitionStyle: .scroll , navigationOrientation: .horizontal, options: nil)
    pageController.dataSource = self
    pageController.delegate = self
    addChild(pageController)
   
    pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
    }

    func updateDotsCount() {
        pageControl.numberOfPages = controllers.count
    }
    
 func setupLayout() {
     view.addSubviews(pageController.view, pageControl)
     view.backgroundColor = .white
     pageController.view.snp.makeConstraints { make in
         make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
         make.height.equalTo(UIScreen.main.bounds.height / 3.5)
     }
     pageControl.snp.makeConstraints { make in
         make.top.equalTo(pageController.view.snp.bottom)
         make.centerX.equalTo(view.snp.centerX)
     }
   }
    

    
}





