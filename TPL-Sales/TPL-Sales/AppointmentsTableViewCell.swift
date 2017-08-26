//
//  AppointmentsTableViewCell.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 25/08/17.
//
//

import UIKit

class AppointmentsTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var leadCustName: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var address: UIButton!
    @IBOutlet weak var appointmentType: UILabel!
    @IBOutlet weak var startEndTime: UILabel!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var we: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
