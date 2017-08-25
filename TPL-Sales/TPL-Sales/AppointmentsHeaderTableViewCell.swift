//
//  AppointmentsHeaderTableViewCell.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 25/08/17.
//
//

import UIKit

class AppointmentsHeaderTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var appointmentsHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
