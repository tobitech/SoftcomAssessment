//
//  PageSectionCell.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

class EmbeddedPhotoElementCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: EmbeddedImageView!
    
    var viewModel: EmbeddedPhotoElementViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
             photoImageView.loadImage(urlString: viewModel.imageUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
