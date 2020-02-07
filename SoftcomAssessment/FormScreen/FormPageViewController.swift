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
        
        addTapGesture()
        setupNavBar()
        setupSectionsTableView()
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
        print("going to next page")
        let nextPage = defaultStoryboard.instantiateViewController(ofType: FormPageViewController.self)
        navigationController?.pushViewController(nextPage, animated: true)
    }
    
    private func setupSectionsTableView() {
        sectionsTableView.delegate = self
        // sectionsTableView.contentInset = .init(top: 0, left: 0, bottom: 180, right: 0)
        sectionsTableView.tableFooterView = UIView()
        sectionsTableView.allowsSelection = false
        sectionsTableView.separatorStyle = .none
    }

}

extension FormPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRow(at: indexPath) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if viewModel.shouldShowSubmit {
            let footer = PageFooter()
            return footer
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.shouldShowSubmit ? 44 : 0
    }
    
}

