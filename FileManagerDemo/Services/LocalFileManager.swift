//
//  LocalFileManager.swift
//  FileManagerDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import SwiftUI

class LocalFileManager {
  
  // MARK: Properties
  static let instance = LocalFileManager()
  let folderName = "MyApp_Images"
  
  // MARK: Init
  init() {
    createFolderIfNeeded()
  }
  
  // MARK: Methods
  func createFolderIfNeeded() {
    guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else {
      return
    }
    
    if !FileManager.default.fileExists(atPath: path) {
      do {
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        print("Success creating folder.")
      } catch let error {
        print("Error creating folder. \(error)")
      }
    }
  }
  
  func deleteFolder() {
    guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else {
      return
    }
    
    do {
      try FileManager.default.removeItem(atPath: path)
      print("Success deleting folder.")
    } catch let error {
      print("Error deleting folder. \(error)")
    }
  }
  
  func saveImage(image: UIImage, name: String) -> String {
    guard
      let data = image.jpegData(compressionQuality: 1.0),
      let path = getPathForImage(name: name) else {
      return "Error getting data."
    }
    
    do {
      try data.write(to: path)
      print(path)
      return "Success saving!"
    } catch let error {
      return "Error saving. \(error)"
    }
  }
  
  func getImage(name: String) -> UIImage? {
    guard let path = getPathForImage(name: name)?.path,
          FileManager.default.fileExists(atPath: path) else {
      print("Error getting path.")
      return nil
    }
    
    return UIImage(contentsOfFile: path)
  }
  
  func deleteImage(name:String) -> String {
    guard let path = getPathForImage(name: name)?.path,
          FileManager.default.fileExists(atPath: path) else {
      return "Error getting path."
    }
    
    do {
      try FileManager.default.removeItem(atPath: path)
      return "Successfully deleted."
    } catch let error {
      return "Error deleting image. \(error)"
    }
  }
  
  func getPathForImage(name: String) -> URL? {
    guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(name).jpg") else {
      print("Error getting path.")
      return nil
    }
    
    return path
  }
}
