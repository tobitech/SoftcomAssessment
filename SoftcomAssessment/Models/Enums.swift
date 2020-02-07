//
//  Enums.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 07/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

enum FormElementType: String {
    case text
    case formattednumeric
    case datetime
    case embeddedphoto
    case yesno
}

enum RuleConditionType: String {
    case equals
}

enum RuleActionType: String {
    case show
    case hide
}
