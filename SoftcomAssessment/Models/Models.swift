//
//  Models.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

struct FormData: Decodable {
    let id: String?
    let name: String?
    let pages: [Page]?
}

struct Page: Decodable {
    let label: String?
    let sections: [Section]?
}

struct Section: Decodable {
    let label: String?
    let elements: [Element]?
}

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

struct Rule: Decodable {
    let condition: String?
    let value: String?
    let action: String?
    let otherwise: String?
    let targets: [String]?
}

enum FormElementType: String {
    case text
    case formattednumeric
    case datetime
    case embeddedphoto
    case yesno
}
