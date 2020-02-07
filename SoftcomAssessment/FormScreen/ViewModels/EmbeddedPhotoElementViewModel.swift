//
//  EmbeddedPhotoElementViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 07/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

class EmbeddedPhotoElementViewModel: ElementViewModelType {
    var delegate: ElementViewModelTypeDelegate?
    
    var element: Element
    
    var imageUrl: String
    
    required init(element: Element) {
        self.element = element
        self.imageUrl = element.file ?? ""
    }
}
