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

        
    }
}
