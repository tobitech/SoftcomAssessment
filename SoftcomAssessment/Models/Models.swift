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
    
    var inputType: FormElementType {
        return FormElementType(rawValue: type)!
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
