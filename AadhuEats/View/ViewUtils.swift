//
//  ViewUtils.swift
//  AadhuEats
//
//  Created by Nana on 10/30/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

enum SummaryCellView: Int {
    case date = 1
    case totalFeed
    case totalBreastFeed
    case totalPumped
    case totalLatch
}

enum PumpLogCellView: Int {
    case time = 1
    case type
    case duration
    case volume
}

enum BottleFeedLogCellView: Int {
    case time = 1
    case type
    case milkType
    case volume
}

enum BreastFeedLogCellView: Int {
    case time = 1
    case type
    case orientation
    case duration
}
