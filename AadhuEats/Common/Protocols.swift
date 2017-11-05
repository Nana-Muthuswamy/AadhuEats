//
//  Protocols.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

protocol Exportable {
    func export() -> Dictionary<String,Any>
}

protocol DateFormatable {
    static var dateFormatter: DateFormatter {get}
    static var timeFormatter: DateFormatter {get}
}

extension DateFormatable {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        return formatter
    }
    static var dateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        return formatter
    }
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "hh:mm a"

        return formatter
    }
}
