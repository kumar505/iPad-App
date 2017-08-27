//
//  Extensions.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 27/08/17.
//
//

import UIKit

// MARK: UI Extensions

extension UITextField {
    
    func formatUI(imageName: String, isLeftViewMode: Bool? = true) {

        if imageName != "" {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .center
            if isLeftViewMode! {
                self.leftViewMode = .always
                self.leftView = imageView
                self.leftView?.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
            } else {
                self.rightViewMode = .always
                self.rightView = imageView
                self.rightView?.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
            }
        }
    }
}

extension UINavigationBar {
    
    func formatUI(barTintcolor: UIColor? = ColorConstants.orangeColor, tintColor: UIColor? = UIColor.white) {
        self.barTintColor = barTintcolor
        self.tintColor = tintColor
        self.titleTextAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0),
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
}

