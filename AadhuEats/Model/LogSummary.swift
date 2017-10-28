//
//  LogSummary.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

struct LogSummary: Exportable {
    var date: Date
    var logs: Array<Log>

    var totalFeedVolume: Int {
        return logs.filter{$0.type != LogType.breastPump}.reduce(0){$0 + $1.volume}
    }
    var totalBreastFeedVolume: Int {
        return logs.filter{$0.type == LogType.breastFeed || ($0.type == LogType.bottleFeed && $0.milkType == MilkType.breast)}.reduce(0){$0 + $1.volume}
    }
    var totalBreastPumpVolume: Int {
        return logs.filter{$0.type == LogType.breastPump}.reduce(0){$0 + $1.volume}
    }
    var totalDurationMinutes: Int {
        return logs.filter{$0.type == LogType.breastFeed}.reduce(0){$0 + $1.durationMinutes}
    }

    init?(source:Dictionary<String, Any>) {
        guard let logSummaryDate = source[kDate] as? Date, let summaryLogs = source[kLogs] as? Array<Dictionary<String,Any>> else {
            return nil
        }

        date = logSummaryDate

        logs = Array<Log>()
        for logDict in summaryLogs {
            if let log = Log(source: logDict) {
                logs.append(log)
            }
        }
    }

    func export() -> Dictionary<String,Any> {
        var exportDict = Dictionary<String,Any>()

        exportDict.updateValue(date, forKey: kDate)

        var exportLogs = Array<Dictionary<String,Any>>()
        for log in logs {
            exportLogs.append(log.export())
        }
        exportDict.updateValue(exportLogs, forKey: kLogs)

        return exportDict
    }
}
