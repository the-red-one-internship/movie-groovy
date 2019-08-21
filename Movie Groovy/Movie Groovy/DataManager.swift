//
//  DataManager.swift
//  Movie Groovy
//
//  Created by admin on 20/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class DataManager {
    //private var arrayDict = NSMutableArray()
    private let fileName = "/Users/admin/Documents/Workspace/movie-groovy/Movie Groovy/Movie Groovy/List"
    
    func saveUploadedFilesSet(filename: [String : Any]) {
        let file = FileHandle(forWritingAtPath: "\(fileName).json")
        
        if file != nil {
            do {
                if let jsonData = try JSONSerialization.data(withJSONObject: filename, options: .init(rawValue: 0)) as? Data {
                    print(NSString(data: jsonData, encoding: 1)!)
                    file?.write(jsonData)
                }
            }
            catch {
                
            }
            file?.closeFile()
        } else {
            print("Ooops! Something went wrong!")
        }
    }
    
    func getUploadedFileSet(filename: String) {
        if let path = Bundle.main.path(forResource: "assets/\(filename)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                    // do stuff
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
}
