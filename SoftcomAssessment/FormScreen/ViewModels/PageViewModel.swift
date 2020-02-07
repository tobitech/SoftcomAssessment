//
//  PageViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

class PageViewModel: NSObject {
    
    var label: String
    var sections: [Section]
    
    init(page: Page) {
        self.sections = page.sections ?? []
        self.label = page.label ?? ""
    }
    
    private func elementForRow(at indexPath: IndexPath) -> Element {
        let section = sections[indexPath.section]
        let elements = section.elements ?? []
        
        return elements[indexPath.row]
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> ElementViewModelType {
        let element = elementForRow(at: indexPath)
        
        switch element.inputType {
        case .embeddedphoto:
            return EmbeddedPhotoElementViewModel(element: element)
        case .text:
            return TextElementViewModel(element: element)
        case .yesno:
            return YesNoElementViewModel(element: element)
        case .formattednumeric:
            return FormattedNumericElementViewModel(element: element)
        case .datetime:
            return DateElementViewModel(element: element)
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        let element = elementForRow(at: indexPath)
        
        switch element.inputType {
        case .embeddedphoto:
            return 228
        case .yesno:
            return 47
        default:
            return 90
        }
    }
}

extension PageViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].elements?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elementForRow(at: indexPath)
        
        switch element.inputType {
        case .embeddedphoto:
            let cell: EmbeddedPhotoElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? EmbeddedPhotoElementViewModel
            return cell
        case .text:
            let cell: TextElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? TextElementViewModel
            return cell
        case .yesno:
            let cell: YesNoElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? YesNoElementViewModel
            return cell
        case .formattednumeric:
            let cell: FormattedNumericElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? FormattedNumericElementViewModel
            return cell
        case .datetime:
            let cell: DateElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? DateElementViewModel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].label ?? ""
    }
    
}
