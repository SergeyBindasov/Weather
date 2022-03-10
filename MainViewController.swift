//
//  MainViewController.swift
//  Weather
//
//  Created by Sergey on 04.03.2022.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var citiesArray: [AnyObject] = []
    
    private lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AddCityCell.self, forCellWithReuseIdentifier: String(describing: AddCityCell.self))
        collection.register(CurrentWeatherCell.self, forCellWithReuseIdentifier: String(describing: CurrentWeatherCell.self))
        collection.delegate = self
        collection.dataSource = self
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        return collection
    }()
    
    private lazy var pageDots: UIPageControl = {
        let dots = UIPageControl()
        dots.numberOfPages = 2
        
        if #available(iOS 14.0, *) {
            dots.backgroundStyle = .automatic
        } else {
            // Fallback on earlier versions
        }
        dots.pageIndicatorTintColor = UIColor(named: K.BrandColors.lightText)
        dots.currentPageIndicatorTintColor = .black
        dots.hidesForSinglePage = true
       
        return dots
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setuoLayout()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.settings), style: .plain, target: self, action: #selector(settingsButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.location), style: .plain, target: self, action: #selector(loactionButtonPressed))
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blackText)
    
    }
}
// MARK: - CollectionView Methods
extension MainViewController: UICollectionViewDataSource {
    
    
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
        let addCell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AddCityCell.self), for: indexPath) as? AddCityCell
        return addCell!
        } else {
            let currentWeatherCell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CurrentWeatherCell.self), for: indexPath) as? CurrentWeatherCell
            return currentWeatherCell!
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageDots.currentPage = indexPath.item
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
}






// MARK: - Classs Methods
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
    
    func setuoLayout() {
        view.addSubviews(pageDots, weatherCollectionView)
        
        pageDots.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        weatherCollectionView.snp.makeConstraints { make in
            make.top.equalTo(pageDots.snp.bottom).offset(5)
            make.leading.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
       
    }
    
    
}
