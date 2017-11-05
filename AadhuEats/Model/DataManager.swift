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

    // Cache file path
    private let archiveURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("AadhuEatsLog")

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
        if let savedLogHistory = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? Array<Dictionary<String,Any>> {
            for logSummaryArr in savedLogHistory {
                if let logSummary = LogSummary(source: logSummaryArr) {
                    _logHistory.append(logSummary)
                }
            }
        }
    }
    
    // MARK: Util Methods
    // TBD: Error Handling
    func addLog(_ log: Log) -> Bool {

        if let matchedIndex = _logHistory.index(where: { (logSummary) -> Bool in            
            return (log.date.absolute() == logSummary.date.absolute())
        }) {
            // Get the matched summary and add the log
            var matchedSummary = _logHistory.remove(at: matchedIndex)
            var matchedSummaryLogs = matchedSummary.logs
            matchedSummaryLogs.append(log)
            matchedSummary.logs = matchedSummaryLogs.sorted{$0.date > $1.date}
            // Add back the updated summary
            _logHistory.insert(matchedSummary, at: matchedIndex)

        } else { // Create new log summary and add to the log history
            var logHistoryList = _logHistory
            let newLogSummary = LogSummary(date: log.date.absolute(), logs: [log])
            logHistoryList.append(newLogSummary)
            _logHistory = logHistoryList.sorted{$0.date > $1.date}
        }

        return true
    }

    func replaceLog(at indexPath: IndexPath, with log: Log) -> Bool {
        if deleteLog(at: indexPath) {
            return addLog(log)
        }

        return false
    }

    func deleteLog(at indexPath: IndexPath) -> Bool {
        var summaryLog = _logHistory.remove(at: indexPath.section)
        summaryLog.logs.remove(at: indexPath.row)

        if summaryLog.logs.count > 0 {
            _logHistory.insert(summaryLog, at: indexPath.section)
        }

        return true
    }

    // Reload log history
    // TBD: CloudKit integration
    func reloadLogHistory() {
        // Reload from saved logs, if present
        if let savedLogHistory = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? Array<Dictionary<String,Any>> {
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
        NSKeyedArchiver.archiveRootObject(logHistoryCache, toFile: archiveURL.path)
    }
}

extension DataManager {

    func loadTestData() {
        let newDate = Date().startOfDay()
        let calendar = Calendar.autoupdatingCurrent
        var dateComponents = calendar.dateComponents([.hour,.day,.month,.year], from: newDate)

        dateComponents.hour = 8
        let todayLog1Date = calendar.date(from: dateComponents)!
        dateComponents.hour = 11
        let todayLog2Date = calendar.date(from: dateComponents)!
        dateComponents.hour = 14
        let todayLog3Date = calendar.date(from: dateComponents)!

        dateComponents.day = dateComponents.day! - 1
        dateComponents.hour = 8
        let yesterdayLog1Date = calendar.date(from: dateComponents)!
        dateComponents.hour = 11
        let yesterdayLog2Date = calendar.date(from: dateComponents)!
        dateComponents.hour = 14
        let yesterdayLog3Date = calendar.date(from: dateComponents)!

        let todayLog1 = Log(date: todayLog1Date, type: .pumpSession, milkType: .breast, breastOrientation: .both, volume: 100, duration: 20)
        let todayLog2 = Log(date: todayLog2Date, type: .breastFeed, milkType: .breast, breastOrientation: .right, volume: 0, duration: 40)
        let todayLog3 = Log(date: todayLog3Date, type: .bottleFeed, milkType: .formula, breastOrientation: .none, volume: 100, duration: 0)

        let yesterdayLog1 = Log(date: yesterdayLog1Date, type: .pumpSession, milkType: .breast, breastOrientation: .both, volume: 100, duration: 20)
        let yesterdayLog2 = Log(date: yesterdayLog2Date, type: .breastFeed, milkType: .breast, breastOrientation: .left, volume: 0, duration: 40)
        let yesterdayLog3 = Log(date: yesterdayLog3Date, type: .bottleFeed, milkType: .breast, breastOrientation: .none, volume: 100, duration: 0)

        let todayLogSummaryDate = newDate.absolute()
        let yesterdayLogSummaryDate = newDate.previous()

        let todayLogSummary = LogSummary(date: todayLogSummaryDate, logs: [todayLog1,todayLog2,todayLog3])
        let yesterdayLogSummary = LogSummary(date: yesterdayLogSummaryDate, logs: [yesterdayLog1,yesterdayLog2,yesterdayLog3])

        _logHistory = [todayLogSummary,yesterdayLogSummary]
    }
}
