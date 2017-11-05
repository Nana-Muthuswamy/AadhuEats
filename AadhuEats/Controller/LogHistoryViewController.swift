//
//  LogHistoryViewController.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class LogHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var logHistoryData: Array<LogSummary> {
        return DataManager.shared.logHistory.sorted{$0.date > $1.date}
    }

    private var numberOfSectionsToDisplay: Int {
        // TBD: Based on selected Summary row's logs, need to calculate rows.
        return DataManager.shared.logHistory.count
    }

    private var sectionDisplayed = -1 // default value

    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSectionsToDisplay
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == sectionDisplayed {
            return logHistoryData[section].logs.count + 1 // Consdering Summary cell view display too
        } else {
            return 1 // Default row for Summary cell view display
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TBD: On row selections, pick appropriate cell identifier based on indexpath.
        let logSummary = logHistoryData[indexPath.section]

        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: kSummaryCellIdentifier) {

                (cell.viewWithTag(SummaryCellView.date.rawValue) as? UILabel)?.text = logSummary.displayDate
                (cell.viewWithTag(SummaryCellView.totalFeed.rawValue) as? UILabel)?.text = "\(logSummary.displayTotalFeedVolume)"
                (cell.viewWithTag(SummaryCellView.totalBreastFeed.rawValue) as? UILabel)?.text = "\(logSummary.displayTotalBreastFeedVolume)"
                (cell.viewWithTag(SummaryCellView.totalPumped.rawValue) as? UILabel)?.text = "\(logSummary.displayTotalBreastPumpVolume)"
                (cell.viewWithTag(SummaryCellView.totalLatch.rawValue) as? UILabel)?.text = "\(logSummary.displayTotalDuration)"

                return cell
            }

        default:
            let log = logSummary.logs[indexPath.logRow()]

            switch log.type {
            case .pumpSession:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kPumpLogCellIdentifier) {
                    (cell.viewWithTag(PumpLogCellView.time.rawValue) as? UILabel)?.text = log.displayTime
                    (cell.viewWithTag(PumpLogCellView.duration.rawValue) as? UILabel)?.text = log.displayDuration
                    (cell.viewWithTag(PumpLogCellView.volume.rawValue) as? UILabel)?.text = log.displayVolume
                    return cell
                }
            case .bottleFeed:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kBottleFeedLogCellIdentifier) {
                    (cell.viewWithTag(BottleFeedLogCellView.time.rawValue) as? UILabel)?.text = log.displayTime
                    (cell.viewWithTag(BottleFeedLogCellView.milkType.rawValue) as? UIImageView)?.image = log.milkType == .breast ? UIImage(named: "BreastMilkType") : UIImage(named: "FormulaMilkType")
                    (cell.viewWithTag(PumpLogCellView.volume.rawValue) as? UILabel)?.text = log.displayVolume
                    return cell
                }
            case .breastFeed:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kBreastFeedLogCellIdentifier) {
                    (cell.viewWithTag(BreastFeedLogCellView.time.rawValue) as? UILabel)?.text = log.displayTime
                    (cell.viewWithTag(BreastFeedLogCellView.orientation.rawValue) as? UILabel)?.text = log.breastOrientation.description
                    (cell.viewWithTag(BreastFeedLogCellView.duration.rawValue) as? UILabel)?.text = log.displayDuration
                    return cell
                }
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.row > 0 else {
            return false
        }

        return true
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if sectionDisplayed == indexPath.section {
                sectionDisplayed = -1
            } else {
                sectionDisplayed = indexPath.section
            }

            tableView.reloadData()
        }
    }
    // TBD: Data operations done in delegate method. Instead should make use of data source methods.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeRowAction = UITableViewRowAction(style: .destructive, title: "Remove") { (action, path) in
            if (DataManager.shared.deleteLog(at: IndexPath(row: indexPath.logRow(), section: indexPath.section))) {
                self.tableView.reloadData()
            }
        }
        let editRowAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, path) in
            self.performSegue(withIdentifier: kLogDetailsSegue, sender: indexPath)
        }
        return [removeRowAction,editRowAction]
    }

    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kLogDetailsSegue {
            guard let targetViewController = segue.destination.contentViewController as? LogDetailsViewController else {return}
            if let indexPath = sender as? IndexPath {
                targetViewController.selectedLogIndexPath = IndexPath(row: indexPath.logRow(), section: indexPath.section)
                targetViewController.model = logHistoryData[indexPath.section].logs[indexPath.logRow()]
            }
        }
    }
}

// File scoped extension to return decremented row values of indexpath applicable just for this controller class
// This is to avoid manipulating the indexpath's row all over the controller's code.
fileprivate extension IndexPath {
    func logRow() -> Int {
        return (self.row - 1)
    }
}
