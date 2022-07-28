//
//  DayWeatherViewController.swift
//  Weather
//
//  Created by Sergey on 23.05.2022.
//

import Foundation
import UIKit
import SnapKit
import Charts

class ThreeHourForecastViewController: UIViewController {
    
    var city: CityCoordintes
    
    var dailyWeatherArray = [DayDetailsModel]()
    var network = HourlyDetailsNetworkManager()

    var entries = [ChartDataEntry]()
    
    init(city: CityCoordintes) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = city.cityName
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = self
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        
        chartView.xAxis.labelFont = UIFont(name: "Rubik-Regular", size: 10) ?? .systemFont(ofSize: 10)
        chartView.leftAxis.labelFont = UIFont(name: "Rubik-Regular", size: 10) ?? .systemFont(ofSize: 10)
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.centerAxisLabelsEnabled = false
        chartView.xAxis.axisLineColor = UIColor(named: K.BrandColors.blue) ?? .blue
        chartView.leftAxis.axisLineColor = UIColor(named: K.BrandColors.blue) ?? .blue
        chartView.leftAxis.axisLineWidth = 0.7
        chartView.xAxis.axisLineWidth = 0.7
        chartView.animate(xAxisDuration: 1.5)
        chartView.leftAxis.granularity = 15
        chartView.rightAxis.enabled = false
        chartView.backgroundColor = .white
        chartView.xAxis.valueFormatter = DateValueFormatter()
        if UserDefaults.standard.bool(forKey: "temp") == true {
            chartView.leftAxis.axisMinimum = -15
            chartView.leftAxis.axisMaximum = 40
        } else {
            chartView.leftAxis.axisMinimum = 0
            chartView.leftAxis.axisMaximum = 105
        }
        return chartView
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.register(DayDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: DayDetailsTableViewCell.self))
        table.dataSource = self
        table.delegate = self
        table.isScrollEnabled = false
        table.separatorColor = UIColor(named: K.BrandColors.blue)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Прогноз на 24 часа"
        network.fetchWeatherBy(latitude: city.latitude, longitude: city.longitude)
        network.delegate = self
        setupLayout()
    
}
                                    }

extension ThreeHourForecastViewController: ChartViewDelegate {
    
   
}

extension ThreeHourForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyWeatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayDetailsTableViewCell.self), for: indexPath) as! DayDetailsTableViewCell
        cell.updateWeather(with: dailyWeatherArray[indexPath.row])
        return cell
    }
    
}

extension ThreeHourForecastViewController: DayDetailsWeatherDelegate {
    func didUpdateDayDetailsWeather(_ weatherManager: HourlyDetailsNetworkManager, weather: [DayDetailsModel]) {
       
        DispatchQueue.main.async {
            for weather in weather {
                self.dailyWeatherArray.append(weather)
                self.tableView.reloadData()
                let dataEntry = ChartDataEntry(x: weather.time, y: weather.currentTemp)
                self.entries.append(dataEntry)
                let lineSet = LineChartDataSet(entries: self.entries, label: "Динамика на сутки")
                lineSet.drawCirclesEnabled = false
                lineSet.mode = .cubicBezier
                lineSet.lineWidth = 2
                lineSet.setColor(UIColor(named: K.BrandColors.blue) ?? .blue)
                lineSet.fill = ColorFill(cgColor: UIColor(named: K.BrandColors.blue)!.cgColor)
                lineSet.fillAlpha = 0.7
                lineSet.drawFilledEnabled = true
                
                lineSet.valueFont = UIFont(name: "Rubik-Medium", size: 12) ?? .systemFont(ofSize: 10)
                let data = LineChartData(dataSet: lineSet)
                data.setValueFormatter(DigitValueFormatter())
                self.chartView.xAxis.setLabelCount(self.entries.count, force: true)
                self.chartView.data = data

                }
              
            }

        }
    }
    
    




extension ThreeHourForecastViewController {
    
 func setupLayout() {
     view.backgroundColor = .white
        view.addSubviews(scroll)
     scroll.addSubviews(mainView)
     mainView.addSubviews(cityLabel, chartView, tableView)
     
     scroll.snp.makeConstraints { make in
         make.top.bottom.equalToSuperview()
         make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
         make.width.equalTo(view.snp.width)
     }
     
     mainView.snp.makeConstraints { make in
         make.edges.equalToSuperview()
         make.width.equalToSuperview()
         make.height.equalTo(1400)
     }
           
       
        cityLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainView).offset(32)
            make.top.equalTo(mainView).offset(15)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(15)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(0)
            make.width.equalToSuperview()
            make.bottom.equalTo(mainView)
        }
        
        
    }
}


