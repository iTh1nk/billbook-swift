//
//  ContentView.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ContentView: View {
  
  @State private var storedUsername: String = UserDefaults.standard.string(forKey: "Username") ?? ""
  @EnvironmentObject var enUser: EnUser
  
  @State private var selectedTab: Int = 0
  
  var body: some View {
    
    TabView(selection: $selectedTab) {
      
      NavigationView {
        VStack {
          HomeView()
        }
        .navigationBarTitle("Home")
        .navigationBarItems(
          leading:
            enUser.enLoggedIn ?
            Text("Hi: \(String(self.enUser.enUsername.components(separatedBy: "@")[0]))").foregroundColor(.green) :
            Text("Welcome to Billbook - iOS").foregroundColor(.gray),
          trailing:
            Image(systemName: "house")
        )
      }.tabItem {
        Image(systemName: "house")
        Text("Home")
      }.tag(0)
      
      NavigationView {
        VStack {
          Spacer()
          StatementView(cycles: [])
        }
        .navigationBarTitle("Statement")
        .navigationBarItems(
          leading:
            enUser.enLoggedIn ?
            Text("Hi: \(String(self.enUser.enUsername.dropLast(12)))").foregroundColor(.green) :
            Text(""),
          trailing: Image(systemName: "doc.plaintext"))
      }.tabItem {
        Image(systemName: "doc.plaintext")
        Text("Statement")
      }.tag(1)
      
      NavigationView {
        VStack {
          ActivityView()
        }
        .navigationBarTitle("Activity")
        .navigationBarItems(
          leading:
            enUser.enLoggedIn ?
            Text("Hi: \(String(self.enUser.enUsername.dropLast(12)))").foregroundColor(.green) :
            Text(""),
          trailing: Image(systemName: "dollarsign.circle"))
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
    .onAppear{
      if (UserDefaults.standard.string(forKey: "Username") != nil) {
        enUser.enLoggedIn = true
        enUser.enUsername = UserDefaults.standard.string(forKey: "Username")!
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(EnUser())
      .preferredColorScheme(.dark)
  }
}
