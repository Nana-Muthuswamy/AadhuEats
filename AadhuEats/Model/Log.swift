//
//  Log.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

enum LogType {
    case bottleFeed
    case breastFeed
    case breastPump

    func description() -> String {
        switch self {
        case .bottleFeed:
            return "BottleFeed"
        case .breastFeed:
            return "BreastFeed"
        case .breastPump:
            return "BreastPump"
        }
    }
}

enum MilkType {
    case breast
    case formula

    func description() -> String {
        switch self {
        case .breast:
            return "Breast"
        case .formula:
            return "Formula"
        }
    }
}

enum BreastOrientation {
    case right
    case left
    case both

    func description() -> String {
        switch self {
        case .right:
            return "Right"
        case .left:
            return "Left"
        case .both:
            return "Both"
        }
    }
}

struct Log: VolumeConvertible {
    var date = Date()
    var type: LogType
    var milkType: MilkType
    var breastOrientation: BreastOrientation
    var volume: Double
    var durationMinutes: Int

    func description() -> String {
        return "Log of type \"\(type.description)\" with milkType \"\(milkType.description)\" and breastOrientation \"\(breastOrientation)\" tracked at \"\(date)\" for volume \"\(volume)\" in durationMinutes \"\(durationMinutes)\""
    }
}
