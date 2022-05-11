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
    
   var places: [CityCoordintes] = []
    
    var pageController: UIPageViewController!
    var pageControl = UIPageControl()
    let network = ThreeHourWeatherNetworkManager()
    var myArray = [ThreeHourWeatherModel]()
    var forecastArray = [ForecastWeatherModel]()
    let forecast = ForecastWeatherNetworkManager()
    let geo = GeocodingRequest()
   
    var controllers: [UIViewController] = []
    
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
       
        createCurrentWeatherVC()
       
     
      // Network
       //network.fetchThreeHourWeatherBy(cityName: "moscow")
        network.onDataUpdate = { [weak self] (data: [ThreeHourWeatherModel]) in
            self?.useData(data: data)
            }
        //forecast.fetchWeekWeather()
        forecast.onDataUpdate = { [weak self] (data: [ForecastWeatherModel]) in
            self?.uploadForcast(data: data)
        }
            
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
        dailyClickLabel.textColor = .red
    }
    
    @objc func monthTapped(sender:UITapGestureRecognizer) {
        monthClickLabel.textColor = .red
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
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
                
               
                print("move back \(index)" )
                return controllers[index - 1]
            } else { return nil }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                
                
                print("move foreward \(index)" )
                return controllers[index + 1]
            } else { return nil }
        }
        return nil
    }
    
    
}
    
// MARK: - Class Methods
extension MainViewController {
    
    func createCurrentWeatherVC() -> [UIViewController]? {
       let array = realm.objects(CityCoordintes.self)
        do {
            if array.count == 0 {
                let addVC = AddViewController()
                self.controllers.append(addVC)
            } else {
              
            array.forEach { place in

                let newCity = CurrentWeatherViewController(cityName: place.cityName, latitude: place.latitude, longitude: place.longitude)
                print(place.cityName)
                network.fetchWeatherBy(latitude: place.latitude, longitude: place.longitude)
                forecast.fetchWeatherBy(latitude: place.latitude, longitude: place.longitude)
            
                self.controllers.append(newCity)
            }
               
            }
        } catch {
            print("ошибка при создании CurrentWeatherVC \(error)")
        }
       return controllers
    }
    
//    func updateCities() {
//
//        let array = realm.objects(CityCoordintes.self)
//         do {
//             if let lastAddded = array.last {
//                 let newCity = CurrentWeatherViewController(cityName: lastAddded.cityName, latitude: lastAddded.latitude, longitude: lastAddded.longitude)
//                 self.controllers.append(newCity)
//             }
//         } catch {
//             print("ошибка при обновлении города \(error)")
//         }
//    }
    

    func saveCity(city: CityCoordintes) {
        do {
            try realm.write({
                realm.add(city)
            })
        } catch {
            print("ошибка при сохранении города \(error)")
        }
        
    }
    
    func loadCities() {
        cities = realm.objects(CityCoordintes.self)
    }
    
  
    
    func useData(data: [ThreeHourWeatherModel]) -> [ThreeHourWeatherModel] {
        myArray = data
        dailyWeatherCollection.reloadData()
        return myArray
    }
    
    func uploadForcast(data: [ForecastWeatherModel]) -> [ForecastWeatherModel] {
        forecastArray = data
        print(forecastArray)
        forecastTableView.reloadData()
        return forecastArray
    }
    
//    func makeArray() -> (Double, Double) {
//        if let array = cities?.toArray(ofType: CityCoordintes.self) {
//
//        for i in array {
//            return (i.latitude, i.longitude)
//        }
//    }
//    }
    
    

    
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
            self.loadCities()
            self.updateDotsCount()
          
        
            self.dismiss(animated: true, completion: nil)
        }
        let decline = UIAlertAction(title: "Отмена", style: .default) { action in
         
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(decline)
        present(alert, animated: true, completion: nil)
       
    }
    // DElegate
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
     view.addSubviews(scroll)
     scroll.addSubviews(mainView)
    mainView.addSubviews(pageController.view, pageControl, dailyClickLabel, dailyWeatherCollection, monthLabel, monthClickLabel, forecastTableView)
    // view.backgroundColor = .white
     
     scroll.snp.makeConstraints { make in
         make.top.bottom.equalToSuperview()
         make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
         make.width.equalTo(view.snp.width)
     }
     
     mainView.snp.makeConstraints { make in
         make.edges.equalToSuperview()
        // make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
         make.width.height.equalToSuperview()
     }
     
     pageController.view.snp.makeConstraints { make in
         make.top.equalTo(pageControl.snp.bottom).offset(5)
         //make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
        // make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
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
         //make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
       
     }
     
     dailyWeatherCollection.snp.makeConstraints { make in
         make.top.equalTo(dailyClickLabel.snp.bottom).offset(10)
//         make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
//         make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
         make.leading.equalTo(mainView).offset(16)
         make.trailing.equalTo(mainView).offset(-16)
         make.height.equalTo(UIScreen.main.bounds.height / 10)
     }
     
     monthLabel.snp.makeConstraints { make in
         make.top.equalTo(dailyWeatherCollection.snp.bottom).offset(16)
         //make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
         make.leading.equalTo(mainView).offset(16)
     }
     
     monthClickLabel.snp.makeConstraints { make in
         make.top.equalTo(dailyWeatherCollection.snp.bottom).offset(16)
         make.trailing.equalTo(mainView).offset(-16)
         //make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
     }
     
     forecastTableView.snp.makeConstraints { make in
//         make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
//         make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
         make.leading.equalTo(mainView).offset(16)
         make.trailing.equalTo(mainView).offset(-16)
         make.top.equalTo(monthClickLabel.snp.bottom).offset(10)
         make.bottom.equalTo(mainView)
     }
   }
    

    
}





