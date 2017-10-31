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
}

enum MilkType: Int {
    case breast = 1
    case formula
}

enum BreastOrientation: Int {
    case right = 1
    case left
    case both
    case none

    var description: String {
        switch self {
        case .right:
            return "Right"
        case .left:
            return "Left"
        case .both:
            return "Both"
        case .none:
            return ""
        }
    }
}
