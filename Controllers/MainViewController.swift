//
//  MainViewController.swift
//  Weather
//
//  Created by Sergey on 04.03.2022.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class MainViewController: UIViewController {
    
    
    let realm = try! Realm()
    
    //var cities: Results<CityCoordintes>?
    
    var currentWeatherControllersArray: [UIViewController] = []
    var currentCityIndex: Int? //= 0
    var threeHourForecastArray = [ThreeHourWeatherModel]()
    var dailyForecastArray = [DailyForecastWeatherModel]()
    
    var pageViewController: UIPageViewController!
    var pageControl = UIPageControl()
    
    let threeHourForecastNetworkMangaer = ThreeHourWeatherNetworkManager()
    let dailyForecastNetworkManager = DailyForecastWeatherNetworkManager()
    var geocodingNetworkManager = GeocodingRequest()
    
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
        collection.register(ThreeHourForecastWeatherCell.self, forCellWithReuseIdentifier: String(describing: ThreeHourForecastWeatherCell.self))
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
        tv.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
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
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // NETWORK
        geocodingNetworkManager.delegate = self
        threeHourForecastNetworkMangaer.delegate = self
        dailyForecastNetworkManager.delegate = self
        
        ifNoPlacesYet()
        
        //createCurrentWeatherVC()
       //loadForecast(at: currentCity)
        
        // Layout
        //setupPageController()
        //setupLayout()
        
        
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
        if let cityIndex = currentCityIndex {
        let day = ThreeHourForecastViewController(city: array[cityIndex])
        show(day, sender: nil)
        }
    }
    
    @objc func monthTapped(sender:UITapGestureRecognizer) {
        monthClickLabel.textColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
            self.currentWeatherControllersArray.append(newCityVC)
            self.updateDotsCount()
        }
    }
}

extension MainViewController: ThreeHourWeatherDelegate {
    func didUpdateHourWeather(_ weatherManager: ThreeHourWeatherNetworkManager, weather: [ThreeHourWeatherModel]) {
        DispatchQueue.main.async {
            for w in weather {
                self.threeHourForecastArray.append(w)
                self.dailyWeatherCollection.reloadData()
            }
        }
    }
}

extension MainViewController: ForecastWeatherDelegate {
    func didUpdateForecastWeather(_ weatherManager: DailyForecastWeatherNetworkManager, weather: [DailyForecastWeatherModel]) {
        DispatchQueue.main.async {
            for w in weather {
                self.dailyForecastArray.append(w)
                self.forecastTableView.reloadData()
            }
        }
    }
}


//MARK: - CollectionViewMethods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return threeHourForecastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyWeatherCollection.dequeueReusableCell(withReuseIdentifier: String(describing: ThreeHourForecastWeatherCell.self), for: indexPath) as! ThreeHourForecastWeatherCell
        
        cell.updateWeather(with: threeHourForecastArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ThreeHourForecastWeatherCell
        cell.isTapped()
    }
    
}
//MARK: - TableViewMethods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyForecastTableViewCell.self), for: indexPath) as! DailyForecastTableViewCell
        cell.updateWeather(with: dailyForecastArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = 10
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = DailyDetailsWeatherViewController(index: indexPath.row, forecastArray: dailyForecastArray)
        navigationController?.show(details, sender: nil)
    }
}


//MARK: - UIPageViewControllerDelegate & UIPageViewControllerDataSource
extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first, let index = currentWeatherControllersArray.firstIndex(of: currentViewController) {
                currentCityIndex = index
                pageControl.currentPage = index
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = currentWeatherControllersArray.firstIndex(of: viewController) {
            
            currentCityIndex = Int(index)
            /// ПРОБЛЕМА С ДВОЙНОЙ ПОДГРУЗКОЙ ДАННЫХ ПРИ СВАЙПЕ НАЗАД
            updateTables()
            
           loadForecast(at: currentCityIndex)
            print("move back \(String(describing: currentCityIndex))" )
            if index > 0 {
                return currentWeatherControllersArray[index - 1]
            } else { return nil }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = currentWeatherControllersArray.firstIndex(of: viewController) {
            if index > 0 {
                print("move foreward \(String(describing: currentCityIndex))" )
                updateTables()
               
                loadForecast(at: currentCityIndex)
            }
            if index < currentWeatherControllersArray.count - 1 {
                return currentWeatherControllersArray[index + 1]
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
            //currentCity = 0
                if let index = currentCityIndex {
                    threeHourForecastNetworkMangaer.fetchWeatherBy(latitude: array[index].latitude, longitude: array[index].longitude)
                    dailyForecastNetworkManager.fetchWeatherBy(latitude: array[index].latitude, longitude: array[index].longitude)
            }
//
//        } catch {
//            print("ошибка при загрузке погоды в таблицы \(error)")
       }
    }

    func createCurrentWeatherVC() -> [UIViewController]? {
        let array = realm.objects(CityCoordintes.self)
        do {
//            if array.count == 0 {
//                let addVC = AddViewController()
//
//                self.controllers.append(addVC)
//                hideUIelements()
//
//            } else {
            currentCityIndex = 0
                array.forEach { place in
                    let newCity = CurrentWeatherViewController(cityName: place.cityName, latitude: place.latitude, longitude: place.longitude)
                    self.currentWeatherControllersArray.append(newCity)

                }
            loadForecast(at: currentCityIndex)
            }
//        } catch {
//            print("ошибка при создании CurrentWeatherVC \(error)")
//        }
        return currentWeatherControllersArray
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
            self.geocodingNetworkManager.getCityCoordinatesBy(name: cityFromTF)
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
        pageViewController = UIPageViewController(transitionStyle: .scroll , navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        addChild(pageViewController)
        
        pageViewController.setViewControllers([currentWeatherControllersArray[0]], direction: .forward, animated: false)
    }
    
    func updateDotsCount() {
        pageControl.numberOfPages = currentWeatherControllersArray.count
    }
    
    /// UI
    
    func ifNoPlacesYet() {
        let array = realm.objects(CityCoordintes.self)
        if array.count == 0 {
            view = AddCityView()
        
        } else {
            createCurrentWeatherVC()
            setupPageController()
            setupLayout()
        }
    }
    
    
//    func hideUIelements() {
//        dailyClickLabel.isHidden = true
//        monthLabel.isHidden = true
//        monthClickLabel.isHidden = true
//        dailyWeatherCollection.isHidden = true
//        forecastTableView.isHidden = true
//    }
  
    func updateTables() {
        threeHourForecastArray = []
        dailyForecastArray = []
        dailyWeatherCollection.reloadData()
        forecastTableView.reloadData()
    }
    
    func setupLayout() {
        view.addSubviews(scroll)
        scroll.addSubviews(mainView)
        mainView.addSubviews(pageViewController.view, pageControl, dailyClickLabel, dailyWeatherCollection, monthLabel, monthClickLabel, forecastTableView)
        
        scroll.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1050)
        }
        
        pageViewController.view.snp.makeConstraints { make in
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
            make.top.equalTo(pageViewController.view.snp.bottom).offset(16)
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
            make.top.equalTo(monthClickLabel.snp.bottom).offset(5)
            make.bottom.equalTo(mainView)
        }
    }
}
