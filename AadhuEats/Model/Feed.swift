//
//  Feed.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

struct Feed: VolumeConvertible {
    var date: Date
    var type: Int
    var milkType: Int
    var breastOrientation: Int
    var volume: Double
    var durationMinutes: Int

}
