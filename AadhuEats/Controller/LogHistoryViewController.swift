//
//  LogHistoryViewController.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class LogHistoryViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var logHistoryData: Array<LogSummary> {
        return DataManager.shared.logHistory.sorted{$0.date > $1.date}
    }

    var numberOfRowsToDisplay: Int {
        // TBD: Based on selected Summary row's logs, need to calculate rows.
        return DataManager.shared.logHistory.count
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsToDisplay
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TBD: On row selections, pick appropriate cell identifier based on indexpath.
        if let cell = tableView.dequeueReusableCell(withIdentifier: kSummaryCellIdentifier) {

            let data = logHistoryData

            (cell.viewWithTag(SummaryCellView.date.rawValue) as? UILabel)?.text = data[indexPath.row].displayDate
            (cell.viewWithTag(SummaryCellView.totalFeed.rawValue) as? UILabel)?.text = "\(data[indexPath.row].displayTotalFeedVolume)"
            (cell.viewWithTag(SummaryCellView.totalBreastFeed.rawValue) as? UILabel)?.text = "\(data[indexPath.row].displayTotalBreastFeedVolume)"
            (cell.viewWithTag(SummaryCellView.totalPumped.rawValue) as? UILabel)?.text = "\(data[indexPath.row].displayTotalBreastPumpVolume)"
            (cell.viewWithTag(SummaryCellView.totalLatch.rawValue) as? UILabel)?.text = "\(data[indexPath.row].displayTotalDurationMinutes)"

            return cell
        }

        return UITableViewCell()
    }
}

