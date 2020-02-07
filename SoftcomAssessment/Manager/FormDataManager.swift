//
//  FormViewModel.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation

class FormDataManager {
    
    // MARK: Properties
    static let shared = FormDataManager()
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
    
    func numberOfItems() -> Int {
        return formData?.pages?.count ?? 0
    }
    
    func pageForController(at index: Int) -> Page {
        let pages = formData?.pages ?? []
        return pages[index]
    }
    
}
