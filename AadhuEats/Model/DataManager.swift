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
    private var logHistory: Array<LogSummary>

    // Private Init to suppress instantiation
    private init() {
        logHistory = Array<LogSummary>()
        // Load from saved logs, if present
        if let savedLogHistory = UserDefaults.standard.array(forKey:"history") as? Array<Dictionary<String,Any>> {
            for logSummaryArr in savedLogHistory {
                if let logSummary = LogSummary(source: logSummaryArr) {
                    logHistory.append(logSummary)
                }
            }
        }
    }

    // Reload log history
    // TBD: CloudKit integration
    func reloadLogHistory() {
        // Reload from saved logs, if present
        if let savedLogHistory = UserDefaults.standard.array(forKey:"history") as? Array<Dictionary<String,Any>> {
            logHistory = Array<LogSummary>()
            for logSummaryArr in savedLogHistory {
                if let logSummary = LogSummary(source: logSummaryArr) {
                    logHistory.append(logSummary)
                }
            }
        }
    }

    // Cache log history
    // TBD: CloudKit integration
    func cacheLogHistory() {
        // Save current logs
        if logHistory.count > 0 {
            UserDefaults.standard.set(logHistory, forKey: kSavedLogHistory)
        } else { // Remove cached logs
            UserDefaults.standard.removeObject(forKey: kSavedLogHistory)
        }
    }
}
