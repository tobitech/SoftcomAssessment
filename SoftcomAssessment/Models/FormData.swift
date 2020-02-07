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


