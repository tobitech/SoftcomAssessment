//
//  DateElementCell.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 06/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

class DateElementCell: UITableViewCell {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    let datePicker = UIDatePicker()
    
    var viewModel: DateElementViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            updateCell(with: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        self.showDatePicker()
    }
    
    private func showDatePicker() {
        datePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDoneBarButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelBarButton))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        inputField.inputAccessoryView = toolbar
        inputField.inputView = datePicker
    }

    @objc private func handleDoneBarButton() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let text = formatter.string(from: datePicker.date)
        inputField.text = text
        viewModel?.inputValue = text
        self.endEditing(true)
    }
    
    @objc private func handleCancelBarButton() {
        self.endEditing(true)
    }

    private func updateCell(with vm: DateElementViewModel) {
        var text = "\(vm.label)"
        if vm.isMandatory {
            text += " (Req.)"
        }
        
        inputLabel.text = text
    }
    
}
