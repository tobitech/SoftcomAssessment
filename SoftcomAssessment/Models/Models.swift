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
    let type: String?
    let label: String?
    let isMandatory: Bool?
    let unique_id: String?
    let rules: [Rule]?
}

struct Rule: Decodable {
    let condition: String?
    let value: String?
    let action: String?
    let otherwise: String?
    let targets: [String]?
}
