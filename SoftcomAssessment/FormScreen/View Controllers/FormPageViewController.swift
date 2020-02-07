//
//  ViewController.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

class FormPageViewController: UIViewController {
    
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var viewModel: PageViewModel!  {
       didSet {
           sectionsTableView.dataSource = viewModel.self
           sectionsTableView.reloadData()
       }
   }
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var sectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = navigationController?.viewControllers.firstIndex(of: self) {
            viewModel = PageViewModel(pageIndex: index)
        }
        
        viewModel.formRulesChanged = {
            self.sectionsTableView.reloadData()
        }
        
        addTapGesture()
        setupNavBar()
        setupSectionsTableView()
        setupKeyboardHandling()
    }
    
    private func setupNavBar() {
        
        if let name = viewModel.dataManager.formData?.name {
            navigationItem.title = name
        }
        pageTitleLabel.text = viewModel.label
        
        if !viewModel.shouldShowSubmit {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func handleNext() {
        let nextPage = defaultStoryboard.instantiateViewController(ofType: FormPageViewController.self)
        navigationController?.pushViewController(nextPage, animated: true)
    }
    
    private func setupSectionsTableView() {
        sectionsTableView.delegate = self
        sectionsTableView.tableFooterView = UIView()
        sectionsTableView.allowsSelection = false
        sectionsTableView.separatorStyle = .none
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
     @objc private func keyboardWillShow(notification: NSNotification) {
         if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
             sectionsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
         }
     }

     @objc private func keyboardWillHide(notification: NSNotification) {
         sectionsTableView.contentInset = .zero
     }

}

extension FormPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRow(at: indexPath) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if viewModel.shouldShowSubmit {
            let footer = PageFooter()
            footer.delegate = self
            return footer
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.shouldShowSubmit ? 44 : 0
    }
    
}

extension FormPageViewController: PageFooterDelegate {
    func didSubmitForm() {
        let dataManager = FormDataManager.shared
        let invalidElements = dataManager.validateForm()
        
        if invalidElements.count > 0 {
            var message = "Please fill the following fields correctly: \n"
            for element in invalidElements {
                guard let label = element.label else {
                    continue
                }
                message += label + "\n"
            }
            
            showAlert(with: message)
        } else {
            let vc = defaultStoryboard.instantiateViewController(ofType: SuccessViewController.self)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
