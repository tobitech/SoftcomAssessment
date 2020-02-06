//
//  ElementViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

protocol ElementViewModelType {
    
    var element: Element { get set}
    
    var type: FormElementType { get }
    var uniqueId: String { get }
    var rules: [Rule] { get }
    
    init(element: Element)
}

extension ElementViewModelType {
    
    var type: FormElementType {
        return FormElementType(rawValue: element.type)!
    }
    
    var uniqueId: String {
        return element.unique_id
    }
    
    var rules: [Rule] {
        return element.rules
    }
}

class EmbeddedPhotoElementViewModel: ElementViewModelType {
    var element: Element
    
    required init(element: Element) {
        self.element = element
    }
}

class TextElementViewModel: ElementViewModelType {
    var element: Element
    
    var inputValue: String = "" {
        didSet {
            print(inputValue)
        }
    }
    
    var label: String
    var isMandatory: Bool
    
    required init(element: Element) {
        self.element = element
        self.label = element.label ?? ""
        self.isMandatory = element.isMandatory ?? false
    }
}

class YesNoElementViewModel: ElementViewModelType {
    var element: Element
    
    var inputValue = false {
        didSet {
            print(inputValue)
        }
    }
    
    var label: String
    var isMandatory: Bool
    
    required init(element: Element) {
        self.element = element
        self.label = element.label ?? ""
        self.isMandatory = element.isMandatory ?? false
    }
}

class DateElementViewModel: ElementViewModelType {
    var element: Element
    
    var inputValue = Date() {
        didSet {
            print(inputValue)
        }
    }
    
    var label: String
    var isMandatory: Bool
    
    required init(element: Element) {
        self.element = element
        self.label = element.label ?? ""
        self.isMandatory = element.isMandatory ?? false
    }
}
