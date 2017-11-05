//
//  Extensions.swift
//  AadhuEats
//
//  Created by Nana on 11/4/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation
import UIKit

extension Date {

    func startOfDay() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var dateComps = calendar.dateComponents([.second,.minute,.hour,.day,.month,.year], from: self)

        dateComps.second = 0
        dateComps.minute = 0
        dateComps.hour = 0

        return calendar.date(from: dateComps) ?? self
    }

    func endOfDay() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var dateComps = calendar.dateComponents([.second,.minute,.hour,.day,.month,.year], from: self)

        dateComps.second = 59
        dateComps.minute = 59
        dateComps.hour = 23

        return calendar.date(from: dateComps) ?? self
    }

    func absolute() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var dateComps = calendar.dateComponents([.day,.month,.year], from: self)

        return calendar.date(from: dateComps) ?? self
    }

    func previous() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var dateComps = calendar.dateComponents([.second,.minute,.hour,.day,.month,.year], from: self)

        dateComps.day! -= 1

        return calendar.date(from: dateComps) ?? self
    }

    func next() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var dateComps = calendar.dateComponents([.second,.minute,.hour,.day,.month,.year], from: self)

        dateComps.day! += 1

        return calendar.date(from: dateComps) ?? self
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        if (self is UINavigationController) {
            return (self as! UINavigationController).viewControllers[0]
        } else {
            return self
        }
    }
}
