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
    var shouldShowSubmit = false
    var dataManager: FormDataManager!
    
    var formRulesChanged: (() -> ())?
    
    // MARK: Used to modify tableView based on rule.
    var ruleToBeEnforced: Rule?
    var ruleEnforcer: Element?
    
    // MARK: Init
    init(dataManager: FormDataManager = FormDataManager.shared, pageIndex: Int) {
        self.dataManager = dataManager
        let page = dataManager.pageForController(at: pageIndex)
        self.sections = page.sections ?? []
        self.label = page.label ?? ""
        
        if pageIndex == dataManager.numberOfItems() - 1 {
            shouldShowSubmit = true
        }
    }
    
    private func elementForRow(at indexPath: IndexPath) -> Element {
        let section = sections[indexPath.section]
        let elements = section.elements ?? []
        
        let element = elements[indexPath.row]
        
        return element
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
    
    private func setRuleEnforcer(indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let elements = section.elements ?? []
        
        let element = elements[indexPath.row]
        
        if (indexPath.row + 1) < elements.count {
            let nextElement = elements[indexPath.row + 1]
            for rule in element.rules {
                if rule.targets?.contains(where: { $0 == nextElement.unique_id }) ?? false {
                    if ruleEnforcer == nil {
                        self.ruleEnforcer = element
                        self.ruleToBeEnforced = rule
                    }
                }
            }
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        let element = elementForRow(at: indexPath)
        
        switch element.inputType {
        case .embeddedphoto:
            return 150
        case .yesno:
            guard let _ = ruleEnforcer else {
                setRuleEnforcer(indexPath: indexPath)
                return 47
            }
            let height = getRowHeight(for: element, defaultHeight: 47)
            return height
        default:
            return 90
        }
    }
    
    private func getRowHeight(for element: Element, defaultHeight: CGFloat) -> CGFloat {
        guard let rule = ruleToBeEnforced else {
            return defaultHeight
        }
        let targets = rule.targets ?? []
        
        if targets.contains(element.unique_id) {
            guard let condition = rule.condition,
                let action = rule.action,
                let otherwise = rule.otherwise,
                let conditionType = RuleConditionType(rawValue: condition),
                let actionType = RuleActionType(rawValue: action),
                let otherwiseType = RuleActionType(rawValue: otherwise)  else {
                return defaultHeight
            }
            
            switch conditionType {
            case .equals:
                if ruleEnforcer?.elementValue == rule.value {
                    switch actionType {
                    case .hide:
                        return 0.0
                    case .show:
                        return defaultHeight
                    }
                } else {
                    switch otherwiseType {
                    case .hide:
                        return 0.0
                    case .show:
                        return defaultHeight
                    }
                }
            }
        } else {
            return defaultHeight
        }
    }
}

extension PageViewModel: ElementViewModelTypeDelegate {
    func inputValueChanged(_ element: Element) {
        
        for rule in element.rules {
            self.ruleToBeEnforced = rule
            self.ruleEnforcer = element
            
            self.formRulesChanged?()
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
