//
//  DateElementViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 07/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

class DateElementViewModel: ElementViewModelType {
    var delegate: ElementViewModelTypeDelegate?
    
    var element: Element
    
    var inputValue: String? {
        didSet {
            // set the element's element value property here.
            element.value = inputValue
            FormDataManager.shared.addAnswer(element: element)
        }
    }
    
    var label: String
    var isMandatory: Bool
    var mode: String
    
    required init(element: Element) {
        self.element = element
        self.label = element.label ?? ""
        self.isMandatory = element.isMandatory ?? false
        self.mode = element.mode ?? ""
    }
}
