//
//  FileLoader.swift
//  SoftcomAssessment
//
//  Created by Oluwatobi Omotayo on 04/02/2020.
//  Copyright © 2020 Oluwatobi Omotayo. All rights reserved.
//

import Foundation


/// Responsible for loading data from file.
class FileLoader {
    
    var bundle: Bundle
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    
    /// This returns `Data` from a specified file name and extension.
    /// - Parameters:
    ///   - name: The name of the file to be loaded.
    ///   - ext: The file extension.
    func loadFileContent(from name: String, ext: String) -> Data? {
        guard let url = bundle.url(forResource: name, withExtension: ext) else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
