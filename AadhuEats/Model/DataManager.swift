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
            UserDefaults.standard.set(_logHistory, forKey: kSavedLogHistory)
        } else { // Remove cached logs
            UserDefaults.standard.removeObject(forKey: kSavedLogHistory)
        }
    }
}
