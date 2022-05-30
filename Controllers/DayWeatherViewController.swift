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

class DayWeatherViewController: UIViewController {
    
    var dailyWeatherArray = [DayDetailsModel]()
    var network = DayDetailsNetworkManager()
    
   // var chartData = [ChartDataEntry]()
    var entries = [ChartDataEntry]()
    
    var timeValues: Double = 0.0
    var weatherValues: Double = 0.0
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Москва"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = self
        
        chartView.leftAxis.axisMinimum = -5
        chartView.leftAxis.axisMaximum = 30
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
        chartView.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
        chartView.xAxis.valueFormatter = DateValueFormatter()
        return chartView
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.register(DayDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: DayDetailsTableViewCell.self))
        table.dataSource = self
        table.delegate = self
        table.separatorColor = UIColor(named: K.BrandColors.blue)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.fetchWeatherBy(latitude: 55.7504, longitude: 37.6175)
        network.delegate = self
        setupLayout()
        
        
        
        
    
}
                                    }

extension DayWeatherViewController: ChartViewDelegate {
    
   
}

extension DayWeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyWeatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayDetailsTableViewCell.self), for: indexPath) as! DayDetailsTableViewCell
        cell.updateWeather(with: dailyWeatherArray[indexPath.row])
        return cell
    }
    
}

extension DayWeatherViewController: DayDetailsWeatherDelegate {
    func didUpdateDayDetailsWeather(_ weatherManager: DayDetailsNetworkManager, weather: [DayDetailsModel]) {
       
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
                lineSet.valueFont = UIFont(name: "Rubik-Medium", size: 10) ?? .systemFont(ofSize: 10)
                let data = LineChartData(dataSet: lineSet)
                self.chartView.xAxis.setLabelCount(self.entries.count, force: true)
                self.chartView.data = data

                }
              
            }

        }
    }
    
    




extension DayWeatherViewController {
    
 func setupLayout() {
        view.addSubviews(cityLabel, chartView, tableView)
        view.backgroundColor = .white
        cityLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(15)
            make.centerX.equalTo(view.center)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(20)
           
            make.centerX.equalTo(view.center)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        
    }
}


