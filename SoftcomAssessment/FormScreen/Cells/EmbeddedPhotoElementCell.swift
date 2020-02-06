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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with url: String) {
        photoImageView.loadImage(urlString: url)
    }
    
}
