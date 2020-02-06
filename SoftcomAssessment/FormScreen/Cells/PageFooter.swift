//
//  PageFooter.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 05/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import UIKit

protocol PageFooterDelegate: class {
    func didSubmitForm()
}

class PageFooter: UIView {
    
    weak var delegate: PageFooterDelegate?
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(submitButton)
        
        submitButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        submitButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        submitButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
    }
    
    @objc private func handleSubmit() {
        print(123)
        delegate?.didSubmitForm()
    }
    
}
