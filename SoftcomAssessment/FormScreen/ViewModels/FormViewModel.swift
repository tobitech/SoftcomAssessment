//
//  FormViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

class FormViewModel {
    
    // MARK: Properties
    var formData: FormData?
    
    // MARK: Init
    
    init() {
        loadFormData()
    }
    
    private func loadFormData() {
        let fileLoader = FileLoader()
        
        guard let data = fileLoader.loadFileContent(from: "pet_adoption", ext: "json") else { return }
        
        do {
            let decoder = JSONDecoder()
            formData = try decoder.decode(FormData.self, from: data)
        } catch {
            print("Something went wrong:", error.localizedDescription, error)
        }
    }
    
}
