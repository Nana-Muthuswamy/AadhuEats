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
}

extension DateFormatable {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        return formatter
    }
}
