//
//  HomeView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct HomeView: View {
  
  @State private var isLogin: Bool = false
  @EnvironmentObject var enObj: EnObj
  @StateObject var digitColor = DigitColor()
  
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
      if enObj.enLoggedIn {
        HStack {
          VStack(alignment: .leading) {
            Text(digitColor.digitColor(digitString: enObj.totalBalance) ? "No Overdue: " : "Total Balance Due: ")
              .font(.headline)
              .foregroundColor(.secondary)
              .padding(.top)
            Text("$\(enObj.totalBalance)")
              .font(.title)
              .fontWeight(.black)
              .foregroundColor(digitColor.digitColor(digitString: enObj.totalBalance) ? .green : .red)
              .lineLimit(3)
              .padding(.vertical)
              .animation(Animation.easeInOut(duration: 1))
            Text("- No action required -".uppercased())
              .font(.caption)
              .foregroundColor(.secondary)
              .opacity(digitColor.digitColor(digitString: enObj.totalBalance) ? 1 : 0)
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
                LoginView().environmentObject(enObj)
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
      
      if enObj.enLoggedIn {
        Button(action: {
          enObj.enLoggedIn = false
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
    HomeView().environmentObject(EnObj())
      .preferredColorScheme(.dark)
  }
}
