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
            
            inputLabel.text = viewModel.label
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
