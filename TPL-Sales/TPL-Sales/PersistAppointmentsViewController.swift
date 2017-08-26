//
//  PersistAppointmentsViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 26/08/17.
//
//

import UIKit

class PersistAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var appointmentTitle: UIBarButtonItem!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cancelBottom: UIButton!
    @IBOutlet weak var form: UITableView!
    
    var isViewAppointments: Bool?
    
    var labels = [["Appointment Type", "Title"],["Start", "End"]]
    var extraLabel = ["Lead/Customer Name", "Phone"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isViewAppointments! {
            labels.insert(extraLabel, at: 0)
        }
    }
    
    // MARK: TableView Delegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count + 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < labels.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideTextFieldLabels") as! FormSideTextFieldLabelTableViewCell
            cell.column1Label.text = labels[indexPath.row][0]
            cell.column2Label.text = labels[indexPath.row][1]
            return cell
        } else if indexPath.row == labels.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideCheckBoxesLabels") as! FormCheckboxLabelTableViewCell
            cell.column1Label.text = "Is all day event"
            cell.column2Label.text = "Confirmed"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "desc") as! FormDescTableViewCell
            cell.descLabel.text = "Description"
            return cell
        }
        
    }
    
    // MARK: Internal functions
    
    @IBAction func performCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func performCancelBottom(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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