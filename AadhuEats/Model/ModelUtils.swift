//
//  Helper.swift
//  AadhuEats
//
//  Created by Nana on 10/27/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

enum LogType: Int {
    case bottleFeed = 1
    case breastFeed
    case breastPump

    var key: String {
        switch self {
        case .bottleFeed:
            return "bottleFeed"
        case .breastFeed:
            return "breastFeed"
        case .breastPump:
            return "breastPump"
        }
    }
}

enum MilkType: Int {
    case breast = 1
    case formula

    var key: String {
        switch self {
        case .breast:
            return "breast"
        case .formula:
            return "formula"
        }
    }
}

enum BreastOrientation: Int {
    case right = 1
    case left
    case both
    case none

    var key: String {
        switch self {
        case .right:
            return "right"
        case .left:
            return "left"
        case .both:
            return "both"
        case .none:
            return "none"
        }
    }
}
