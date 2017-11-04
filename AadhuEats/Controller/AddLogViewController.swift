//
//  AddLogViewController.swift
//  AadhuEats
//
//  Created by Nana on 10/26/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class AddLogViewController: UIViewController {

    @IBOutlet weak var logTypeControl: UISegmentedControl!

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var durationPicker: UIPickerView!
    @IBOutlet weak var volumePicker: UIPickerView!
    @IBOutlet weak var milkTypeControl: UISegmentedControl!
    @IBOutlet weak var breastOrientationControl: UISegmentedControl!

    @IBOutlet weak var durationPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var volumePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var milkTypeControlHeight: NSLayoutConstraint!
    @IBOutlet weak var breastOrientationControlHeight: NSLayoutConstraint!

    // To store the default storyboard height constraint constants for fallback
    var defaultHeights = [NSLayoutConstraint:CGFloat]()

    // Log Model
    var model = Log(date: Date(), type: .pumpSession, milkType: .breast, breastOrientation: .none, volume: 0, duration: 0)

    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Keep track of default constant values of all height constaints
        defaultHeights.updateValue(durationPickerHeight.constant, forKey: durationPickerHeight)
        defaultHeights.updateValue(volumePickerHeight.constant, forKey: volumePickerHeight)
        defaultHeights.updateValue(milkTypeControlHeight.constant, forKey: milkTypeControlHeight)
        defaultHeights.updateValue(breastOrientationControlHeight.constant, forKey: breastOrientationControlHeight)

        // Display default Pump session log details
        logTypeSelected(logTypeControl)
        // Setup Log Date picker
    }

    // MARK: Util Methods

    func saveModel() {
        if (DataManager.shared.addLog(model) == false) {
            let alert = UIAlertController(title: "Operation Failed", message: "Unable to create new log.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            show(alert, sender: self)
        }
    }

    func updateModel(for logType: LogType) {
        model.type = logType
        model.date = datePicker.date

        switch logType {
        case .pumpSession:
            model.duration = durationPicker.selectedRow(inComponent: 0)
            model.volume = volumePicker.selectedRow(inComponent: 0)
            // set defaults for rest
            model.breastOrientation = .both
            model.milkType = .breast
        case .bottleFeed:
            model.milkType = MilkType(rawValue: milkTypeControl.selectedSegmentIndex) ?? .breast
            model.volume = volumePicker.selectedRow(inComponent: 0)
            // set defaults for rest
            model.breastOrientation = .none
            model.duration = 0
        case .breastFeed:
            model.duration = durationPicker.selectedRow(inComponent: 0)
            model.breastOrientation = BreastOrientation(rawValue: breastOrientationControl.selectedSegmentIndex) ?? .both
            // set defaults for rest
            model.milkType = .breast
            model.volume = 0
        }
    }

    func updateUI(for logType: LogType) {
        switch logType {
        case .pumpSession:
            // Remove irrelevant fields
            self.milkTypeControl.alpha = 0
            self.breastOrientationControl.alpha = 0
            self.milkTypeControlHeight.constant = 0
            self.breastOrientationControlHeight.constant = 0

            UIView.animate(withDuration: 1.0, animations: {
                // Display relevant fields
                self.durationPicker.alpha = 1
                self.volumePicker.alpha = 1
                self.durationPickerHeight.constant = self.defaultHeights[self.durationPickerHeight]!
                self.volumePickerHeight.constant = self.defaultHeights[self.volumePickerHeight]!
            })

        case .bottleFeed:
            // Remove irrelevant fields
            self.durationPicker.alpha = 0
            self.breastOrientationControl.alpha = 0
            self.durationPickerHeight.constant = 0
            self.breastOrientationControlHeight.constant = 0

            UIView.animate(withDuration: 1.0, animations: {
                // Display relevant fields
                self.volumePicker.alpha = 1
                self.milkTypeControl.alpha = 1
                self.volumePickerHeight.constant = self.defaultHeights[self.volumePickerHeight]!
                self.milkTypeControlHeight.constant = self.defaultHeights[self.milkTypeControlHeight]!
            })

        case .breastFeed:
            // Remove irrelevant fields
            self.volumePicker.alpha = 0
            self.milkTypeControl.alpha = 0
            self.volumePickerHeight.constant = 0
            self.milkTypeControlHeight.constant = 0

            UIView.animate(withDuration: 1.0, animations: {
                // Display relevant fields
                self.durationPickerHeight.constant = self.defaultHeights[self.durationPickerHeight]!
                self.breastOrientationControlHeight.constant = self.defaultHeights[self.breastOrientationControlHeight]!
                self.durationPicker.alpha = 1
                self.breastOrientationControl.alpha = 1
            })
        }
    }

    func setupDatePicker() {
        datePicker.calendar = Calendar.autoupdatingCurrent
        datePicker.locale = Locale.autoupdatingCurrent
        datePicker.timeZone = TimeZone.autoupdatingCurrent
        datePicker.setDate(model.date, animated: true)
        datePicker.maximumDate = model.date.endOfDay()
    }

    // MARK: Action Methods

    @IBAction func logTypeSelected(_ sender: UISegmentedControl) {

        guard let logType = LogType(rawValue: sender.selectedSegmentIndex) else {return}
        // Update UI and Model for selected log type
        updateUI(for: logType)
    }

    @IBAction func saveLog(_ sender: Any) {
        updateModel(for: (LogType(rawValue: logTypeControl.selectedSegmentIndex) ?? .pumpSession))
        saveModel()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func discardLog(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Picker View Extension
extension AddLogViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            if pickerView == durationPicker {
                return 61
            } else if pickerView == volumePicker {
                return 1000
            } else {
                return 0
            }
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32.0
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60.0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(row)
        default:
            if pickerView == durationPicker {
                return "mins"
            } else if pickerView == volumePicker {
                return "ml"
            } else {
                return ""
            }
        }
    }
}
