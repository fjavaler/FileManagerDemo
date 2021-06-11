//
//  ContentView.swift
//  FileManagerDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: Properties
  @StateObject var vm = ContentViewModel()
  
  // MARK: Body
  var body: some View {
    
    NavigationView {
      
      VStack {
        
        if let image = vm.image {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width:200, height: 200)
            .clipped()
            .cornerRadius(10)
        }
        
        HStack {
          Button(action: {
            vm.saveImage()
          }, label: {
            Text("Save to File Manager")
              .foregroundColor(.white)
              .font(.headline)
              .padding()
              .padding(.horizontal)
              .background(Color.blue)
              .cornerRadius(10.0)
          })
          
          Button(action: {
            vm.deleteImage()
          }, label: {
            Text("Delete from File Manager")
              .foregroundColor(.white)
              .font(.headline)
              .padding()
              .padding(.horizontal)
              .background(Color.red)
              .cornerRadius(10.0)
          })
        }
        
        Text(vm.infoMessage)
          .font(.largeTitle)
          .fontWeight(.semibold)
          .foregroundColor(.purple)
        
        Spacer()
      
      }
      .navigationTitle("File Manager")
    
    }
    
  }
  
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
