//
//  HomeView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct HomeView: View {
  
  @State private var isLogin: Bool = false
  
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
      
      Spacer()
    }
    
    
//    VStack {
//      ZStack {
//        RadialGradient(gradient: Gradient(colors: [.orange, .red]), center: .center, startRadius: 100, endRadius: 370)
//        VStack(alignment: .leading) {
//          Text("STAY ACTIVE").font(.system(size: 30)).fontWeight(.heavy).foregroundColor(Color(red: 0.1, green: 0.6, blue: 0.8, opacity: 1.0))
//          Text("CLOSE YOUR RINGS!").font(.system(size: 30)).fontWeight(.heavy).foregroundColor(Color(red: 0.1, green: 0.6, blue: 0.8, opacity: 1.0))
//        }
//      }
//      .frame(width: 400, height: 200)
//      .ignoresSafeArea()
//      Spacer()
//      HStack {
//        Text("Balance as of cycle: $0")
//          .padding(.horizontal)
//        Spacer()
//      }
//      Spacer()
//      Spacer()
//      Spacer()
//      Spacer()
//      Spacer()
//    }
    
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .preferredColorScheme(.dark)
  }
}
