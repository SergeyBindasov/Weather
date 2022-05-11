//
//  Extensions.swift
//  Weather
//
//  Created by Sergey on 22.02.2022.
//

import UIKit
import RealmSwift

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
