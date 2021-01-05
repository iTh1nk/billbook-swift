//
//  ContentView.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ContentView: View {
  
  @State private var storedUsername: String = UserDefaults.standard.string(forKey: "Username") ?? ""
  @EnvironmentObject var enObj: EnObj
  
  @State private var selectedTab: Int = 0
  
  var body: some View {
    
    TabView(selection: $selectedTab) {
      
      NavigationView {
        VStack {
          HomeView()
            .onAppear{
              if (UserDefaults.standard.string(forKey: "Username") != nil) {
                ActivityViewModel().getBalance(userId: UserDefaults.standard.string(forKey: "UserID")!) { (activity) -> Void in
                  enObj.totalBalance = activity.totalBalance
                }
              }
            }

        }
        .navigationBarTitle("Home")
        .navigationBarItems(
          leading:
            enObj.enLoggedIn ?
            Text("Hi: \(String(self.enObj.enUsername.components(separatedBy: "@")[0]))").foregroundColor(.green) :
            Text("Welcome to Billbook - iOS").foregroundColor(.gray),
          trailing:
            Image(systemName: "house")
        )
      }.tabItem {
        Image(systemName: "house")
        Text("Home")
      }.tag(0)
      
      if enObj.enLoggedIn {
        NavigationView {
          VStack {
            Spacer()
            StatementView(cycles: [])
          }
          .navigationBarTitle("Statement")
          .navigationBarItems(
            leading:
              enObj.enLoggedIn ?
              Text("Hi: \(String(self.enObj.enUsername.components(separatedBy: "@")[0]))").foregroundColor(.green) :
              Text(""),
            trailing: Image(systemName: "doc.plaintext"))
        }
        .tabItem {
          Image(systemName: "doc.plaintext")
          Text("Statement")
        }.tag(1)
        
        NavigationView {
          VStack {
            ActivityView().environmentObject(enObj)
          }
          .navigationBarTitle("Activity")
          .navigationBarItems(
            leading:
              enObj.enLoggedIn ?
              Text("Hi: \(String(self.enObj.enUsername.components(separatedBy: "@")[0]))").foregroundColor(.green) :
              Text(""),
            trailing: Image(systemName: "dollarsign.circle"))
        }
        .onAppear{
          ActivityViewModel().getActivity(userId: UserDefaults.standard.string(forKey: "UserID")!) { (user) in
            enObj.activity = user.user_activities
          }
        }
        .tabItem {
          Image(systemName: "dollarsign.circle")
          Text("Activity")
        }.tag(2)
      }
      
      NavigationView {
        VStack {
          About()
        }
        .navigationBarTitle("About")
        .navigationBarItems(trailing: Image(systemName: "exclamationmark.circle"))
      }.tabItem {
        Image(systemName: "exclamationmark.circle")
        Text("About")
      }.tag(3)
    }
    .onAppear{
      if (UserDefaults.standard.string(forKey: "Username") != nil) {
        enObj.enLoggedIn = true
        enObj.enUsername = UserDefaults.standard.string(forKey: "Username")!
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(EnObj())
      .preferredColorScheme(.dark)
  }
}
