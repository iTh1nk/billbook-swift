//
//  ContentView.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
     
    TabView {
      
      NavigationView {
        VStack {
          HomeView()
        }
        .navigationBarTitle("Home")
        .navigationBarItems(trailing: Image(systemName: "house"))
      }.tabItem {
        Image(systemName: "house")
        Text("Home")
      }
      
      NavigationView {
        VStack {
          StatementView()
        }
        .navigationBarTitle("Statement")
        .navigationBarItems(trailing: Image(systemName: "doc.plaintext"))
      }.tabItem {
        Image(systemName: "doc.plaintext")
        Text("Statement")
      }
      
      NavigationView {
        VStack {
          ActivityView()
        }
        .navigationBarTitle("Activity")
        .navigationBarItems(trailing: Image(systemName: "dollarsign.circle"))
      }.tabItem {
        Image(systemName: "dollarsign.circle")
        Text("Activity")
      }
      
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
  }
}
