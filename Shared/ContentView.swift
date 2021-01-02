//
//  ContentView.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ContentView: View {
  
  @State private var storedUsername: String = UserDefaults.standard.string(forKey: "Username") ?? ""
  @EnvironmentObject private var enUsername: EnUser
  
  @State private var selectedTab: Int = 0
  
  var body: some View {
    
    TabView(selection: $selectedTab) {
      
      NavigationView {
        VStack {
          HomeView()
        }
        .navigationBarTitle("Home")
        .navigationBarItems(leading: Text(self.enUsername.enUsername), trailing: Image(systemName: "house"))
      }.tabItem {
        Image(systemName: "house")
        Text("Home")
      }.tag(0)
      
      NavigationView {
        VStack {
          Spacer()
          StatementView()
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
      
      NavigationView {
        VStack {
          
        }
        .navigationBarTitle("About")
        .navigationBarItems(trailing: Image(systemName: "exclamationmark.circle"))
      }.tabItem {
        Image(systemName: "exclamationmark.circle")
        Text("About")
      }.tag(2)
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(EnUser())
      .preferredColorScheme(.dark)
  }
}
