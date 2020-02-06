//
//  YesNoElementCell.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 06/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

class YesNoElementCell: UITableViewCell {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputSwitch.addTarget(self, action: #selector(handleSwitchChanged(_:)), for: .valueChanged)
    }
    
    @objc func handleSwitchChanged(_ sender: UISwitch) {
        print(sender.isOn)
    }
    
}
