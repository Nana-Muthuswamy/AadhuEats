//
//  LogSummary.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

struct LogSummary {
    var date: Date
    var logs: Array<Log>

    var totalFeedVolume: Double {
        return logs.filter{$0.type != .breastPump}.reduce(0){$0 + $1.volume}
    }
    var totalBreastFeedVolume: Double {
        return logs.filter{$0.type == .breastFeed || ($0.type == .bottleFeed && $0.milkType == .breast)}.reduce(0){$0 + $1.volume}
    }
    var totalBreastPumpVolume: Double {
        return logs.filter{$0.type == .breastPump}.reduce(0){$0 + $1.volume}
    }
    var totalDurationMinutes: Int {
        return logs.filter{$0.type == .breastFeed}.reduce(0){$0 + $1.durationMinutes}
    }
}
