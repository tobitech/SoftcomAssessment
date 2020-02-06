//
//  CollectionViewCell.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

class FormPageCell: UICollectionViewCell {

    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var sectionsTableView: UITableView!
    
    var shouldShowSubmit = false
    
    var viewModel: PageViewModel? {
        didSet {
            sectionsTableView.dataSource = viewModel.self
            sectionsTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionsTableView.delegate = self
        
        sectionsTableView.tableFooterView = UIView()
        sectionsTableView.allowsSelection = false
        sectionsTableView.separatorStyle = .none
    }
    
    func configure(with viewModel: PageViewModel) {
        self.viewModel = viewModel
        pageLabel.text = viewModel.label
    }

}

extension FormPageCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRow(at: indexPath) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if shouldShowSubmit {
            let footer = PageFooter()
            return footer
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return shouldShowSubmit ? 44 : 0
    }
}
