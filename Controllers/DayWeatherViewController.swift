//
//  DayWeatherViewController.swift
//  Weather
//
//  Created by Sergey on 07.06.2022.
//

import Foundation
import UIKit
import SnapKit

class DayWeatherViewController: UIViewController {
    
    var index: Int
    var forecastArray: [ForecastWeatherModel]
    var lastIndex: IndexPath = [1,0]
    
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    private lazy var dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(DateCell.self, forCellWithReuseIdentifier: String(describing: DateCell.self))
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        return collection
    }()
    
    private lazy var dayView: DetailsView = {
        let view = DetailsView(frame: UIScreen.main.bounds, title: "День")
        return view
    }()
    
    private lazy var nightView: DetailsView = {
        let view = DetailsView(frame: UIScreen.main.bounds, title: "Ночь")
        return view
    }()
    
    private lazy var sunAndMoonView: SunAndMoonView = {
        let view = SunAndMoonView()
        return view
    }()
    
    init(index: Int, forecastArray: [ForecastWeatherModel]) {
        self.index = index
        self.forecastArray = forecastArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = forecastArray[index].timezone
        updateUI(with: index)
        setupLayout()
    }
}

extension DayWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DateCell.self), for: indexPath) as! DateCell
        cell.updateUI(with: forecastArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateUI(with: indexPath.item)
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        if lastIndex != indexPath {
            cell.isSelected(condition: true)
            let cellTwo = collectionView.cellForItem(at: lastIndex) as? DateCell
            cellTwo?.isSelected(condition: false)
            lastIndex = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width / 4
        return CGSize(width: width, height: 36)
    }
}

extension DayWeatherViewController {
    
    func updateUI(with index: Int) {
        dayView.updateUI(with: forecastArray[index])
        nightView.updateUI(with: forecastArray[index])
        sunAndMoonView.updateUI(with: forecastArray[index])
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        view.addSubviews(scroll)
        scroll.addSubviews(dateCollectionView, dayView, nightView, sunAndMoonView)
        
        scroll.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
        
        dateCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
        }
        
        dayView.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(350)
        }
        
        nightView.snp.makeConstraints { make in
            make.top.equalTo(dayView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(350)
        }
        
        sunAndMoonView.snp.makeConstraints { make in
            make.top.equalTo(nightView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(350)
            make.bottom.equalToSuperview()
        }
    }
}
