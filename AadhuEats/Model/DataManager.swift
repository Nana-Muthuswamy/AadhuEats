//
//  DataManager.swift
//  AadhuEats
//
//  Created by Nana on 10/27/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

class DataManager {

    // Singleton Instance
    static let shared = DataManager()

    // Log History
    private var _logHistory: Array<LogSummary>
    var logHistory: Array<LogSummary> {
        return _logHistory
    }
    var logHistoryCache: Array<Dictionary<String,Any>> {
        var _logHistoryCache = Array<Dictionary<String,Any>>()
        for log in _logHistory {
            _logHistoryCache.append(log.export())
        }
        return _logHistoryCache
    }

    // Private Init to suppress instantiation
    private init() {
        _logHistory = Array<LogSummary>()
        // Load from saved logs, if present
        if let savedLogHistory = UserDefaults.standard.array(forKey:"history") as? Array<Dictionary<String,Any>> {
            for logSummaryArr in savedLogHistory {
                if let logSummary = LogSummary(source: logSummaryArr) {
                    _logHistory.append(logSummary)
                }
            }
        }
    }

    // Reload log history
    // TBD: CloudKit integration
    func reloadLogHistory() {
        // Reload from saved logs, if present
        if let savedLogHistory = UserDefaults.standard.array(forKey:"history") as? Array<Dictionary<String,Any>> {
            _logHistory = Array<LogSummary>()
            for logSummaryArr in savedLogHistory {
                if let logSummary = LogSummary(source: logSummaryArr) {
                    _logHistory.append(logSummary)
                }
            }
        }
    }

    // Cache log history
    // TBD: CloudKit integration
    func cacheLogHistory() {
        // Save current logs
        if _logHistory.count > 0 {
            UserDefaults.standard.set(logHistoryCache, forKey: kSavedLogHistory)
        } else { // Remove cached logs
            UserDefaults.standard.removeObject(forKey: kSavedLogHistory)
        }
    }
}

extension DataManager {

    func loadTestData() {
        let currentDate = Date()
        let calendar = Calendar.autoupdatingCurrent
        var dateComponents = calendar.dateComponents([.day,.hour], from: currentDate)
        dateComponents.hour = 8
        let todayLog1Date = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.hour = 11
        let todayLog2Date = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.hour = 14
        let todayLog3Date = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.day! -= 1
        let yesterdayLog1Date = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.hour = 17
        let yesterdayLog2Date = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.hour = 20
        let yesterdayLog3Date = calendar.date(byAdding: dateComponents, to: currentDate)

        let todayLog1 = Log(date: todayLog1Date!, type: .pumpSession, milkType: .breast, breastOrientation: .both, volume: 100, duration: 20)
        let todayLog2 = Log(date: todayLog2Date!, type: .breastFeed, milkType: .breast, breastOrientation: .right, volume: 100, duration: 40)
        let todayLog3 = Log(date: todayLog3Date!, type: .bottleFeed, milkType: .formula, breastOrientation: .none, volume: 100, duration: 50)

        let yesterdayLog1 = Log(date: yesterdayLog1Date!, type: .pumpSession, milkType: .breast, breastOrientation: .both, volume: 100, duration: 20)
        let yesterdayLog2 = Log(date: yesterdayLog2Date!, type: .breastFeed, milkType: .breast, breastOrientation: .left, volume: 100, duration: 40)
        let yesterdayLog3 = Log(date: yesterdayLog3Date!, type: .bottleFeed, milkType: .breast, breastOrientation: .none, volume: 100, duration: 50)

        dateComponents = calendar.dateComponents([.day,.month,.year], from: currentDate)
        let todayLogSummaryDate = calendar.date(from: dateComponents)
        dateComponents.day! -= 1
        let yesterdayLogSummaryDate = calendar.date(from: dateComponents)

        let todayLogSummary = LogSummary(date: todayLogSummaryDate!, logs: [todayLog1,todayLog2,todayLog3])
        let yesterdayLogSummary = LogSummary(date: yesterdayLogSummaryDate!, logs: [yesterdayLog1,yesterdayLog2,yesterdayLog3])

        _logHistory = [todayLogSummary,yesterdayLogSummary]
    }
}
