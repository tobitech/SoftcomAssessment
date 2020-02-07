//
//  FormattedNumericElementViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 07/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

class FormattedNumericElementViewModel: ElementViewModelType {
    var element: Element
    
    var inputValue: String = "" {
        didSet {
            print(inputValue)
        }
    }
    
    var label: String
    var isMandatory: Bool
    var keyboardMode: String
    var formattedNumeric: String
    
    required init(element: Element) {
        self.element = element
        self.label = element.label ?? ""
        self.isMandatory = element.isMandatory ?? false
        self.keyboardMode = element.keyboard ?? ""
        self.formattedNumeric = element.formattedNumeric ?? ""
    }
}
