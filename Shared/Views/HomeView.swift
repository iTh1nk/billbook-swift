//
//  HomeView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct HomeView: View {
  
  @State private var isLogin: Bool = false
  @EnvironmentObject var enUser: EnUser
  
//  @State private var showAlert: Bool = true
  
  var body: some View {
    
    VStack {
        ZStack {
          Image("HomeTopBar")
              .resizable()
//              .aspectRatio(contentMode: .fit)
            .frame(width: 400, height: 200)
          HStack {
            VStack(alignment: .leading) {
              Text("STAY ACTIVE")
                .font(.system(size: 30))
                .fontWeight(.heavy).foregroundColor(Color.white)
                .shadow(radius: 10)
                .padding(.bottom, 6)
              Text("CLOSE YOUR RINGS!")
                .font(.system(size: 30))
                .fontWeight(.heavy).foregroundColor(Color.white)
                .shadow(radius: 10)
            }
            Spacer()
          }.padding(.leading, 50)
        }
      .cornerRadius(10)
      .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
      )
      .padding([.top, .horizontal])
      
//      Display User Balance or Login Bar
      

      HStack {
        Text("Check")
      }
      .contentShape(Rectangle())
      .listStyle(SidebarListStyle())
      .onAppear{
        ActivityViewModel().getBalance(userId: "0585fb98-78fc-4363-980a-32d63c32cc3e")
      }
      
      if enUser.enLoggedIn {
        HStack {
          VStack(alignment: .leading) {
            Text("Balance as of current cycle: ")
              .font(.headline)
              .foregroundColor(.secondary)
              .padding(.top)
            Text("$123")
              .font(.title)
              .fontWeight(.black)
              .foregroundColor(.primary)
              .lineLimit(3)
              .padding(.vertical)
            Text("No action required".uppercased())
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .layoutPriority(100)
          Spacer()
        }
        .padding()
      } else {
        ZStack {
          Image("HomeLoginBar")
              .resizable()
  //              .aspectRatio(contentMode: .fit)
            .frame(width: 400, height: 200)
          HStack {
            HStack() {
              Text("Please")
                .font(.system(size: 30))
                .fontWeight(.heavy).foregroundColor(Color.white)
                .shadow(radius: 10)
              Button(action: {
                isLogin.toggle()
              }) {
                Text("Login")
                  .font(.system(size: 30))
                  .underline()
                  .fontWeight(.heavy).foregroundColor(Color.white)
                  .shadow(radius: 10)
              }
              .sheet(isPresented: $isLogin, content: {
                LoginView()
              })
            }
            Spacer()
          }.padding(.leading, 50)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
        )
        .padding([.top, .horizontal])
      }
  
      Spacer()
      
//      Text("")
//        .alert(isPresented: $showAlert, content: {
//            Alert(title: Text("Test"), message: Text("Body Test"))
//        })
      
      if enUser.enLoggedIn {
        Button(action: {
          enUser.enLoggedIn = false
          UserDefaults.standard.removeObject(forKey: "Username")
          UserDefaults.standard.removeObject(forKey: "Exp")
          UserDefaults.standard.removeObject(forKey: "UserID")
          UserDefaults.standard.removeObject(forKey: "Token")
        }) {
          RoundedRectangle(cornerRadius: 10).fill(Color.red)
            .frame(height: 60)
            .overlay(Text("Logout").foregroundColor(.white))
        }
        .padding()
      }
    }
    
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().environmentObject(EnUser())
      .preferredColorScheme(.dark)
  }
}
