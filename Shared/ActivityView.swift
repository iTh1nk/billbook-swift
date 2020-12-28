//
//  ActivityView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ActivityView: View {
  
  var body: some View {
    
    List {
      
      Section(header: Text("2020-03-02")) {
        Text("Activity Details")
        .padding(.leading)
      }
      Section(header: Text("2019-06-09")) {
        Text("Activity Details")
        .padding(.leading)
      }
    }
    .listStyle(SidebarListStyle())
    
  }
  
}

struct ActivityView_Previews: PreviewProvider {
  static var previews: some View {
    ActivityView()
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
