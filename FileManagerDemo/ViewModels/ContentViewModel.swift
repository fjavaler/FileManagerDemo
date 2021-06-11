//
//  ContentViewModel.swift
//  FileManagerDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import Foundation
import UIKit

class ContentViewModel: ObservableObject {
  
  // MARK: Properties
  @Published var image: UIImage? = nil
  let imageName: String = "steve-jobs"
  let manager = LocalFileManager.instance // singleton instance
  @Published var infoMessage: String = ""
  
  // MARK: Init
  init() {
    getImageFromAssetsFolder()
    //getImageFromFileManager()
  }
  
  // MARK: CRUD Operations
  func getImageFromAssetsFolder() {
    image = UIImage(named: imageName)
  }
  
  func getImageFromFileManager() {
    image = manager.getImage(name: imageName)
  }
  
  func saveImage() {
    guard let image = image else {
      return
    }
    
    infoMessage = manager.saveImage(image: image, name: imageName)
  }
  
  func deleteImage() {
    infoMessage = manager.deleteImage(name: imageName)
    manager.deleteFolder()
  }
}
