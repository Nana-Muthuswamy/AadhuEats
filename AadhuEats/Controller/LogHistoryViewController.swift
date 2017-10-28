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
            return cell
        }

        return UITableViewCell()
    }
}

