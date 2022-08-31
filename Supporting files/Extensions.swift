//
//  Extensions.swift
//  Weather
//
//  Created by Sergey on 22.02.2022.
//

import UIKit
import RealmSwift
import Charts

extension UIView {
    func addSubviewWithAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}

extension Date {

func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, E dd MMMM"
    dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: Date())
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        let array = Array(self) as! [T]
        return array
    }
}

public class DateValueFormatter: NSObject, AxisValueFormatter {
    private let dateFormatter = DateFormatter()
    override init() {
        super.init()
        
        dateFormatter.dateFormat = "HH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}

extension String {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}



class DigitValueFormatter : NSObject, ValueFormatter {
    let help = Help()

    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        
        let valueWithoutDecimalPart = help.inCelcius(temp: value)
        return valueWithoutDecimalPart
    }
}
