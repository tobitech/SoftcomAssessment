//
//  PageViewModel+Datasource.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 07/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

/// This impelements a `DataSource`
/// to be used to configure tableview for the page
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
            cell.viewModel?.delegate = self
            return cell
        case .text:
            let cell: TextElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? TextElementViewModel
            cell.viewModel?.delegate = self
            return cell
        case .yesno:
            let cell: YesNoElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? YesNoElementViewModel
            cell.viewModel?.delegate = self
            return cell
        case .formattednumeric:
            let cell: FormattedNumericElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? FormattedNumericElementViewModel
            cell.viewModel?.delegate = self
            return cell
        case .datetime:
            let cell: DateElementCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModelForCell(at: indexPath) as? DateElementViewModel
            cell.viewModel?.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].label ?? ""
    }
    
}
