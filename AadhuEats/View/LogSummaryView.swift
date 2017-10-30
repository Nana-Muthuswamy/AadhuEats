//
//  LogSummaryView.swift
//  AadhuEats
//
//  Created by Nana on 10/30/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class LogSummaryView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var totalFeedVolume: UILabel!
    @IBOutlet weak var totalBreastFeedVolume: UILabel!
    @IBOutlet weak var totalPumpedVolume: UILabel!
    @IBOutlet weak var totalLatchDuration: UILabel!

    var model: Dictionary<String,Any>? {
        didSet {
            if let data = model {
                date.text = data[kDisplayDate] as? String
                totalFeedVolume.text = data[kDisplayTotalFeedVolume] as? String
                totalBreastFeedVolume.text = data[kDisplayTotalBreastFeedVolume] as? String
                totalPumpedVolume.text = data[kDisplayTotalBreastPumpVolume] as? String
                totalLatchDuration.text = data[kDisplayTotalDurationMinutes] as? String
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubViews()
    }

    func initSubViews() {

        let nib = UINib(nibName: "LogSummaryView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds

        addSubview(contentView)
    }

}
