//
//  StatementView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct StatementView: View {
  
  @State private var isShow = false
  @State private var isExpand = false
  @State private var flags: [Bool] = [false, false, false]
  
  let cycles: [Cycle]
  
  var body: some View {
    
      List(cycles) { cycle in
        
        NavigationLink(destination: StatementDetail()) {
          HStack {
            Image(systemName: "doc.plaintext")
            Text(cycle.date)
          }
        }
        
      }
      .contentShape(Rectangle())
      .listStyle(SidebarListStyle())
      .navigationBarTitle("Statement")
    
  }
  

  
  
}

struct StatementView_Previews: PreviewProvider {
  static var previews: some View {
    StatementView(cycles: CycleModelView.cycleTemp)
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
