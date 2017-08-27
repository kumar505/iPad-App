//
//  PersistAppointmentsViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 26/08/17.
//
//

import UIKit

class PersistAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var appointmentTitle: UIBarButtonItem!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cancelBottom: UIButton!
    @IBOutlet weak var form: UITableView!
    
    var isViewAppointments: Bool?
    var appointment: AppointmentDataModel?
    
    var labels = [["Appointment Type", "Title"],["Start", "End"]]
    var extraLabel = ["Lead/Customer Name", "Phone"]
    var isAllDayChecked: Bool = false
    var isConfirmChecked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isViewAppointments! {
            self.appointmentTitle.title = "View Appointment"
            labels.insert(extraLabel, at: 0)
        } else {
            self.appointmentTitle.title = "Add Appointment"
        }
        
        self.navigationController?.navigationBar.formatUI(barTintcolor: ColorConstants.lightBlueColor, tintColor: UIColor.darkGray)
        
        cancelBottom.layer.borderWidth = 1.0
        cancelBottom.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: TableView Delegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count + 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == (labels.count + 1) {
            return 210.0
        }
        if indexPath.row == labels.count {
            return 50.0
        }
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < labels.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideTextFieldLabels") as! FormSideTextFieldLabelTableViewCell
            cell.column1Label.text = labels[indexPath.row][0]
            cell.column2Label.text = labels[indexPath.row][1]
            if labels[indexPath.row][0] == "Appointment Type" {
                cell.column1Field.formatUI(imageName: "down-arrow", isLeftViewMode: false)
            }
            if labels[indexPath.row][0] == "Start" {
                cell.column1Field.formatUI(imageName: "calender", isLeftViewMode: false)
            }
            if labels[indexPath.row][1] == "End" {
                cell.column2Field.formatUI(imageName: "calender", isLeftViewMode: false)
            }
            return cell
        } else if indexPath.row == labels.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideCheckBoxesLabels") as! FormCheckboxLabelTableViewCell
            cell.column1Label.text = "Is all day event"
            cell.column1Button.addTarget(self, action: #selector(self.isAllDayEvent(sender:)), for: .touchUpInside)
            cell.column2Label.text = "Confirmed"
            cell.column2Button.addTarget(self, action: #selector(self.isConfirm(sender:)), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "desc") as! FormDescTableViewCell
            cell.descLabel.text = "Description"
            cell.descTextView.layer.borderWidth = 0.5
            cell.descTextView.layer.cornerRadius = 5.0
            cell.descTextView.layer.borderColor = UIColor.lightGray.cgColor
            cell.descTextView.text = ""
            return cell
        }
        
    }
    
    // MARK: Textfield Delegate functions
    
    
    
    // MARK: Internal functions
    
    @IBAction func performCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func performCancelBottom(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func performSave(_ sender: UIButton) {
        appointments.append(appointment!)
    }
    
    func isAllDayEvent(sender: UIButton) {
        if !isAllDayChecked {
            isAllDayChecked = true
            sender.setImage(UIImage(named: "checkbox-active"), for: .normal)
        } else {
            isAllDayChecked = false
            sender.setImage(UIImage(named: "checkbox-inactive"), for: .normal)
        }
    }
    
    func isConfirm(sender: UIButton) {
        if !isConfirmChecked {
            isConfirmChecked = true
            sender.setImage(UIImage(named: "checkbox-active"), for: .normal)
        } else {
            isConfirmChecked = false
            sender.setImage(UIImage(named: "checkbox-inactive"), for: .normal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
