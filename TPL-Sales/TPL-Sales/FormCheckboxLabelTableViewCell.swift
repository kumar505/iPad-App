//
//  FormCheckboxLabelTableViewCell.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 26/08/17.
//
//

import UIKit

class FormCheckboxLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var column1Label: UILabel!
    @IBOutlet weak var column1Button: UIButton!
    @IBOutlet weak var column2Label: UILabel!
    @IBOutlet weak var column2Button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
