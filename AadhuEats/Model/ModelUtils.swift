//
//  Helper.swift
//  AadhuEats
//
//  Created by Nana on 10/27/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

enum LogType: Int {
    case pumpSession
    case bottleFeed
    case breastFeed
}

enum MilkType: Int {
    case breast
    case formula
}

enum BreastOrientation: Int {
    case left
    case both
    case right
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
