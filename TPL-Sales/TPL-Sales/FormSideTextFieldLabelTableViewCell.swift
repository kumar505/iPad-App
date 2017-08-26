//
//  FormSideTextFieldLabelTableViewCell.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 26/08/17.
//
//

import UIKit

class FormSideTextFieldLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var column1Label: UILabel!
    @IBOutlet weak var column1Field: UITextField!
    @IBOutlet weak var column2Label: UILabel!
    @IBOutlet weak var column2Field: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
