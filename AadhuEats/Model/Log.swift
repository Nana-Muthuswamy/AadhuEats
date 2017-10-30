//
//  Log.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

struct Log: Exportable, DateFormatable {
    var date = Date()
    var type: LogType
    var milkType: MilkType
    var breastOrientation: BreastOrientation
    var volume: Int
    var duration: Int

    var displayDate: String {
        return Log.dateFormatter.string(from: date)
    }

    var displayVolume: String {
        return "\(volume) ml"
    }

    var displayDuration: String {
        return "\(duration) mins"
    }

    init(date: Date, type: LogType, milkType: MilkType, breastOrientation: BreastOrientation, volume: Int, duration: Int) {
        self.date = date
        self.type = type
        self.milkType = milkType
        self.breastOrientation = breastOrientation
        self.volume = volume
        self.duration = duration
    }

    init?(source:Dictionary<String,Any>) {
        // Guard the initiation source
        guard let logDateStr = source[kDate] as? String, let logDate = Log.dateFormatter.date(from:logDateStr),
            let logTypeRaw = source[kType] as? Int, let logType = LogType(rawValue: logTypeRaw),
            let logMilkTypeRaw = source[kMilkType] as? Int, let logMilkType = MilkType(rawValue: logMilkTypeRaw),
            let logBreastOrientationRaw = source[kBreastOrientation] as? Int, let logBreastOrientation = BreastOrientation(rawValue: logBreastOrientationRaw),
            let logVolume = source[kVolume] as? Int,
            let logDuration = source[kDuration] as? Int else {
                return nil
        }

        date = logDate
        type = logType
        milkType = logMilkType
        breastOrientation = logBreastOrientation
        volume = logVolume
        duration = logDuration
    }

    func description() -> String {
        return "Log of type \"\(type)\" with milkType \"\(milkType)\" and breastOrientation \"\(breastOrientation)\" tracked at \"\(date)\" for volume \"\(volume)\" in durationMinutes \"\(duration)\""
    }

    func export() -> Dictionary<String,Any> {

        var exportDict = Dictionary<String,Any>()
        exportDict.updateValue(Log.dateFormatter.string(from: date), forKey: kDate)
        exportDict.updateValue(type.rawValue, forKey: kType)
        exportDict.updateValue(milkType.rawValue, forKey: kMilkType)
        exportDict.updateValue(breastOrientation.rawValue, forKey: kBreastOrientation)
        exportDict.updateValue(volume, forKey: kVolume)
        exportDict.updateValue(duration, forKey: kDuration)

        return exportDict
    }
}
