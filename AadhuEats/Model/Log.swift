//
//  Log.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

struct Log: Exportable {
    var date = Date()
    var type: LogType
    var milkType: MilkType
    var breastOrientation: BreastOrientation
    var volume: Int
    var durationMinutes: Int

    init?(source:Dictionary<String,Any>) {
        // Guard the initiation source
        guard let logDate = source[kDate] as? Date,
            let logTypeRaw = source[kType] as? Int, let logType = LogType(rawValue: logTypeRaw),
            let logMilkTypeRaw = source[kMilkType] as? Int, let logMilkType = MilkType(rawValue: logMilkTypeRaw),
            let logBreastOrientationRaw = source[kBreastOrientation] as? Int, let logBreastOrientation = BreastOrientation(rawValue: logBreastOrientationRaw),
            let logVolume = source[kVolume] as? Int,
            let logDurationMinutes = source[kDurationMinutes] as? Int else {
                return nil
        }

        date = logDate
        type = logType
        milkType = logMilkType
        breastOrientation = logBreastOrientation
        volume = logVolume
        durationMinutes = logDurationMinutes
    }

    func description() -> String {
        return "Log of type \"\(type.key)\" with milkType \"\(milkType.key)\" and breastOrientation \"\(breastOrientation.key)\" tracked at \"\(date)\" for volume \"\(volume)\" in durationMinutes \"\(durationMinutes)\""
    }

    func export() -> Dictionary<String,Any> {

        var exportDict = Dictionary<String,Any>()
        exportDict.updateValue(date, forKey: kDate)
        exportDict.updateValue(type, forKey: type.key)
        exportDict.updateValue(type, forKey: type.key)
        exportDict.updateValue(type, forKey: type.key)
        exportDict.updateValue(type, forKey: type.key)
        exportDict.updateValue(type, forKey: type.key)

        return exportDict
    }
}
