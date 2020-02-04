//
//  PageViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

class PageViewModel {
    
    var label: String
    var sections: [Section]
    
    init(page: Page) {
        self.sections = page.sections ?? []
        self.label = page.label ?? ""
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].elements?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func sectionTitle(for section: Int) -> String {
        return sections[section].label ?? ""
    }
}
