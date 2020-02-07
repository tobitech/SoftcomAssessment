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
    
    var formData: FormData? {
        didSet {
            formElements.removeAll()
            
            let pages = formData?.pages ?? []
            var availableElements = [Element]()
            
            for page in pages {
                let sections = page.sections ?? []
                for section in sections {
                    let elements = section.elements ?? []
                    availableElements += elements
                }
            }
            
            formElements = availableElements
        }
    }
    
    private var formElements = [Element]()
    
    private var answeredElements = [Element]()
    
    
    // MARK: Init
    init() {
        loadFormData()
    }
    
    // MARK: Private Methods
    private func loadFormData() {
        let fileLoader = FileLoader()
        
        guard let data = fileLoader
            .loadFileContent(from: "pet_adoption", ext: "json") else {
                return
        }
        
        do {
            let decoder = JSONDecoder()
            formData = try decoder.decode(FormData.self, from: data)
        } catch {
            print("Something went wrong:", error.localizedDescription, error)
        }
    }
    
    // MARK: Public Methods
    func numberOfItems() -> Int {
        return formData?.pages?.count ?? 0
    }
    
    func pageForController(at index: Int) -> Page {
        let pages = formData?.pages ?? []
        return pages[index]
    }
    
    func addAnswer(element: Element) {
        if !answeredElements.contains(where: { $0.unique_id == element.unique_id }) {
            self.answeredElements.append(element)
        } else {
            if let index = answeredElements.firstIndex(where: { $0.unique_id == element.unique_id }) {
                self.answeredElements[index] = element
            }
        }
    }
    
    func validateForm() -> [Element] {
        var elements = [Element]()
        
        /// get elements we want to validate
        /// based on isMandatory property regardless of the value
        for element in formElements {
            if element.shouldValidate {
                elements.append(element)
            } else {
                continue
            }
        }
        
        /// do the actual validation
        var notValidElements = [Element]()
        for element in elements {
            print(element.unique_id)
            if let filledElement = answeredElements
                .first(where: { $0.unique_id == element.unique_id }) {
                if !filledElement.isValueValid {                
                    notValidElements.append(element)
                }
            } else if !element.isValueValid {
                notValidElements.append(element)
            }
        }
        
        // return elements whose value is not valid
        return notValidElements
    }
}
