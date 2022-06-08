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
import RealmSwift

class MainViewController: UIViewController {
    
    
    let realm = try! Realm()
    
    var cities: Results<CityCoordintes>?
    
    var controllers: [UIViewController] = []
    var currentCity: Int? = 0
    var myArray = [ThreeHourWeatherModel]()
    var forecastArray = [ForecastWeatherModel]()
    
    var pageController: UIPageViewController!
    var pageControl = UIPageControl()
    
    let threeHourNetwork = ThreeHourWeatherNetworkManager()
    let forecast = ForecastWeatherNetworkManager()
    var geo = GeocodingRequest()
    
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dailyWeatherCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(DailyWeatherCell.self, forCellWithReuseIdentifier: String(describing: DailyWeatherCell.self))
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.allowsSelection = true
        collection.isUserInteractionEnabled = true
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 45, height: 85)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 5, bottom: .zero, right: 5)
        return collection
    }()
    
    private lazy var forecastTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(ForecastTableViewCell.self, forCellReuseIdentifier: String(describing: ForecastTableViewCell.self))
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private lazy var dailyClickLabel: UILabel = {
        let label = UILabel()
        label.text = "Подробнее на 24 часа"
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.attributedText = NSAttributedString(string: "Подробнее на 24 часа", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var monthClickLabel: UILabel = {
        let label = UILabel()
        label.text = "25 дней"
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.attributedText = NSAttributedString(string: "25 дней", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "Ежедневный прогноз"
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // NETWORK
        geo.delegate = self
        threeHourNetwork.delegate = self
        forecast.delegate = self
        
        createCurrentWeatherVC()
        //loadForecast(at: currentCity)
        
        // Layout
        setupPageController()
        setupLayout()
        
        
        // Tap
        let tapDaily = UITapGestureRecognizer(target: self, action: #selector(dailyTapped))
        let tapMonth = UITapGestureRecognizer(target: self, action: #selector(monthTapped))
        dailyClickLabel.addGestureRecognizer(tapDaily)
        monthClickLabel.addGestureRecognizer(tapMonth)
        
        // NAV
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.settings), style: .plain, target: self, action: #selector(settingsButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: K.SystemSymbols.location), style: .plain, target: self, action: #selector(loactionButtonPressed))
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blackText)
    }
    
    @objc func dailyTapped(sender:UITapGestureRecognizer) {
        let array = Array(realm.objects(CityCoordintes.self))
        if let cityIndex = currentCity {
        let day = HourForecastViewController(city: array[cityIndex])
        show(day, sender: nil)
        }
    }
    
    @objc func monthTapped(sender:UITapGestureRecognizer) {
        monthClickLabel.textColor = .red
    }
}

//MARK: - Network Delegate Methods
extension MainViewController: GeocodingManagerDelegate {
    func createNewCity(_ networkManager: GeocodingRequest, model: GeocodingModel) {
        DispatchQueue.main.async {
            let newCity = CityCoordintes()
            newCity.cityName = model.cityName
            newCity.latitude = model.latitude
            newCity.longitude = model.longitude
            self.saveCity(city: newCity)
            let newCityVC = CurrentWeatherViewController(cityName: newCity.cityName, latitude: newCity.latitude, longitude: newCity.longitude)
            self.controllers.append(newCityVC)
            self.updateDotsCount()
        }
    }
}

extension MainViewController: ThreeHourWeatherDelegate {
    func didUpdateHourWeather(_ weatherManager: ThreeHourWeatherNetworkManager, weather: [ThreeHourWeatherModel]) {
        DispatchQueue.main.async {
            for w in weather {
                self.myArray.append(w)
                self.dailyWeatherCollection.reloadData()
            }
        }
    }
}

extension MainViewController: ForecastWeatherDelegate {
    func didUpdateForecastWeather(_ weatherManager: ForecastWeatherNetworkManager, weather: [ForecastWeatherModel]) {
        DispatchQueue.main.async {
            for w in weather {
                self.forecastArray.append(w)
                self.forecastTableView.reloadData()
            }
        }
    }
}


//MARK: - CollectionViewMethods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyWeatherCollection.dequeueReusableCell(withReuseIdentifier: String(describing: DailyWeatherCell.self), for: indexPath) as! DailyWeatherCell
        
        cell.updateWeather(with: myArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DailyWeatherCell
        cell.isTapped()
    }
    
}
//MARK: - TableViewMethods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ForecastTableViewCell.self), for: indexPath) as! ForecastTableViewCell
        cell.updateWeather(with: forecastArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = 10
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = DayWeatherViewController(forecastModel: forecastArray[indexPath.row])
        navigationController?.show(details, sender: nil)
    }
}


//MARK: - UIPageViewControllerDelegate & UIPageViewControllerDataSource
extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first, let index = controllers.firstIndex(of: currentViewController) {
                currentCity = index
                pageControl.currentPage = index
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            
            currentCity = Int(index)
            /// ПРОБЛЕМА С ДВОЙНОЙ ПОДГРУЗКОЙ ДАННЫХ ПРИ СВАЙПЕ НАЗАД
            updateTables()
            loadForecast(at: currentCity)
            print("move back \(String(describing: currentCity))" )
            if index > 0 {
                return controllers[index - 1]
            } else { return nil }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                print("move foreward \(String(describing: currentCity))" )
                updateTables()
                loadForecast(at: currentCity)
            }
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else { return nil }
        }
        return nil
    }
}

// MARK: - Class Methods
extension MainViewController {
    /// REALM
    func saveCity(city: CityCoordintes) {
        do {
            try realm.write({
                realm.add(city)
            })
        } catch {
            print("ошибка при сохранении города \(error)")
        }
    }
    
    func loadForecast(at index: Int?) {
        let array = realm.objects(CityCoordintes.self)
        do {
            
                if let index = currentCity {
                    threeHourNetwork.fetchWeatherBy(latitude: array[index].latitude, longitude: array[index].longitude)
                    forecast.fetchWeatherBy(latitude: array[index].latitude, longitude: array[index].longitude)
            }
            
        } catch {
            print("ошибка при загрузке погоды в таблицы \(error)")
        }
    }
    
    func createCurrentWeatherVC() -> [UIViewController]? {
        let array = realm.objects(CityCoordintes.self)
        do {
            if array.count == 0 {
                let addVC = AddViewController()
                self.controllers.append(addVC)
                hideUIelements()
                
            } else {
                
                array.forEach { place in
                    let newCity = CurrentWeatherViewController(cityName: place.cityName, latitude: place.latitude, longitude: place.longitude)
                    self.controllers.append(newCity)
                    loadForecast(at: 0)
                }
            }
        } catch {
            print("ошибка при создании CurrentWeatherVC \(error)")
        }
        return controllers
    }

    /// ACTIONS

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
            self.geo.getCityCoordinatesBy(name: cityFromTF)
           
            self.dismiss(animated: true, completion: nil)
        }
        let decline = UIAlertAction(title: "Отмена", style: .default) { action in
            
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(decline)
        present(alert, animated: true, completion: nil)
        
    }
    // PageControllerSetup
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
    
    /// UI
    func hideUIelements() {
        dailyClickLabel.isHidden = true
        monthLabel.isHidden = true
        monthClickLabel.isHidden = true
        dailyWeatherCollection.isHidden = true
        forecastTableView.isHidden = true
    }
  
    func updateTables() {
        myArray = []
        forecastArray = []
        dailyWeatherCollection.reloadData()
        forecastTableView.reloadData()
    }
    
    func setupLayout() {
        view.addSubviews(scroll)
        scroll.addSubviews(mainView)
        mainView.addSubviews(pageController.view, pageControl, dailyClickLabel, dailyWeatherCollection, monthLabel, monthClickLabel, forecastTableView)
        
        scroll.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        pageController.view.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(5)
            make.leading.equalTo(mainView).offset(16)
            make.trailing.equalTo(mainView).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height / 3.5)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(mainView)
            make.centerX.equalTo(mainView.snp.centerX)
        }
        
        dailyClickLabel.snp.makeConstraints { make in
            make.top.equalTo(pageController.view.snp.bottom).offset(16)
            make.trailing.equalTo(mainView).offset(-16)
        }
        
        dailyWeatherCollection.snp.makeConstraints { make in
            make.top.equalTo(dailyClickLabel.snp.bottom).offset(10)
            make.leading.equalTo(mainView).offset(16)
            make.trailing.equalTo(mainView).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height / 10)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(dailyWeatherCollection.snp.bottom).offset(16)
            make.leading.equalTo(mainView).offset(16)
        }
        
        monthClickLabel.snp.makeConstraints { make in
            make.top.equalTo(dailyWeatherCollection.snp.bottom).offset(16)
            make.trailing.equalTo(mainView).offset(-16)
        }
        
        forecastTableView.snp.makeConstraints { make in
            make.leading.equalTo(mainView).offset(16)
            make.trailing.equalTo(mainView).offset(-16)
            make.top.equalTo(monthClickLabel.snp.bottom).offset(10)
            make.bottom.equalTo(mainView)
        }
    }
}
