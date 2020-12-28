//
//  StatementView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct StatementView: View {
  
  @State private var isShow = false
  
  var body: some View {
    
    List {
      
      Section(header: Text("2020")) {
        Button("12-09") {
          isShow.toggle()
        }
        .sheet(isPresented: $isShow, content: {
          StatementDetails()
        })
        .padding(.leading)
      }
      Section(header: Text("2019")) {
        Button("12-09") {
          isShow.toggle()
        }
        .sheet(isPresented: $isShow, content: {
          StatementDetails()
        })
        .padding(.leading)
      }
    }
    .listStyle(SidebarListStyle())
    
  }
  
}

struct StatementView_Previews: PreviewProvider {
  static var previews: some View {
    StatementView()
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
