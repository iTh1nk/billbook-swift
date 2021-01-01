//
//  ContentView.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ContentView: View {
  
  @State private var selectedTab: Int = 1
  
  var body: some View {
    
    TabView(selection: $selectedTab) {
      
      NavigationView {
        VStack {
          HomeView()
        }
        .navigationBarTitle("Home")
        .navigationBarItems(trailing: Image(systemName: "house"))
      }.tabItem {
        Image(systemName: "house")
        Text("Home")
      }.tag(0)
      
      NavigationView {
        VStack {
          Spacer()
          StatementView(cycles: CycleModelView.cycleTemp)
        }
        .navigationBarTitle("Statement")
        .navigationBarItems(trailing: Image(systemName: "doc.plaintext"))
      }.tabItem {
        Image(systemName: "doc.plaintext")
        Text("Statement")
      }.tag(1)
      
      NavigationView {
        VStack {
          ActivityView()
        }
        .navigationBarTitle("Activity")
        .navigationBarItems(trailing: Image(systemName: "dollarsign.circle"))
      }.tabItem {
        Image(systemName: "dollarsign.circle")
        Text("Activity")
      }.tag(2)
      
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
  }
}
