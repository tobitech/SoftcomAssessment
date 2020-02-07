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
    
    var viewModel: YesNoElementViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            updateCell(with: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputSwitch.addTarget(self, action: #selector(handleSwitchChanged(_:)), for: .valueChanged)
    }
    
    @objc func handleSwitchChanged(_ sender: UISwitch) {
        viewModel?.inputValue = sender.isOn ? "Yes" : "No"
    }
    
    private func updateCell(with vm: YesNoElementViewModel) {
        var text = "\(vm.label)"
        if vm.isMandatory {
            text += " (Req.)"
        }
        
        inputLabel.text = text
    }
    
}
