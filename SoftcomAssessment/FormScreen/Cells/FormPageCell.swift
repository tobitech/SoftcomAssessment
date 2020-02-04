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
    
    var viewModel: PageViewModel? {
        didSet {
            sectionsTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionsTableView.delegate = self
        sectionsTableView.dataSource = self
        sectionsTableView.tableFooterView = UIView()
        sectionsTableView.allowsSelection = false
    }
    
    func configure(with viewModel: PageViewModel) {
        self.viewModel = viewModel
        pageLabel.text = viewModel.label
    }

}

extension FormPageCell: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionElementCellId", for: indexPath) as! SectionElementCell
        cell.textLabel?.text = "Element"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.sectionTitle(for: section)
    }
}
