//
//  TextElementCell.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 06/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

class TextElementCell: UITableViewCell {
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    var viewModel: TextElementViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            updateCell(with: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputField.addTarget(self, action: #selector(handleInputChanged), for: .editingChanged)
    }
    
    private func updateCell(with vm: TextElementViewModel) {
        var text = "\(vm.label)"
        if vm.isMandatory {
            text += " (Req.)"
        }
        
        inputLabel.text = text
    }
    
    @objc private func handleInputChanged() {
        viewModel?.inputValue = inputField.text
    }
    
}
