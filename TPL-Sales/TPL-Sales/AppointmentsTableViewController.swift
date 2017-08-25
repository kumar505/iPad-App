//
//  AppointmentsTableViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 25/08/17.
//
//

import UIKit

class AppointmentsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsTableViewHeader") as! AppointmentsHeaderTableViewCell
        return cell
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsTableView") as! AppointmentsTableViewCell
        
        if indexPath.row != 0 {
            cell.topView.isHidden = true
        }
        
        return cell
    }
}
