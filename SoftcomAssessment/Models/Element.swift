//
//  Element.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 07/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

struct Element: Decodable {
    let type: String
    let unique_id: String
    let rules: [Rule]
    let file: String?
    let label: String?
    let isMandatory: Bool?
    let keyboard: String?
    let formattedNumeric: String?
    let mode: String?
    
    var value: String?
    
    var elementValue: String {
        return value ?? ""
    }
    
    var inputType: FormElementType {
        return FormElementType(rawValue: type)!
    }
    
    var shouldValidate: Bool {
        guard let isMandatory = isMandatory else {
            return false
        }
        
        if isMandatory {
            return true
        } else if !isMandatory && elementValue.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var isValueValid: Bool {
        guard let isMandatory = isMandatory else {
            return false
        }
        
        if isMandatory && !elementValue.isEmpty {
            return true
        } else if !isMandatory && !elementValue.isEmpty {
            return true
        } else {
            return false
        }
    }
}
