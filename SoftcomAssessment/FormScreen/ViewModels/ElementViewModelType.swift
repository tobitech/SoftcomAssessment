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
    var delegate: ElementViewModelTypeDelegate? { get set }
    
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

protocol ElementViewModelTypeDelegate {
    func inputValueChanged(_ element: Element)
}
