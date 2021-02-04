//
//  MediumView.swift
//  BillBook-WidgetExtension
//
//  Created by Chao Feng on 2/3/21.
//

import Foundation
import SwiftUI
import WidgetKit

struct MediumView: View {
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      Color(red: 215/255, green: 63/255, blue: 12/255)
      HStack {
        VStack {
          HStack {
            Image("favicon")
              .resizable()
              .frame(width: 60, height: 60)
            VStack {
              Text("BillBook")
                .foregroundColor(.white)
                .font(.system(size: 12))
                .fontWeight(.bold)
              Text("@We0mmm")
                .foregroundColor(.white)
                .font(.system(size: 8))
            }
          }
          Text("Current Cycle")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.bottom, 5)
            .shadow(color: .black, radius: 2)
          Text(entry.notification)
            .foregroundColor(.white)
            .fontWeight(.heavy)
            .font(.system(size: 23))
            .shadow(color: .black, radius: 2)
        }
        .padding(.bottom)
        .padding(.horizontal)
        Spacer()
        VStack {
//          Image("fireworks")
//            .resizable()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(
          Image("fireworks")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .mask(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .leading, endPoint: .trailing))
        )
      }
    }
  }
}

struct MediumView_Previews: PreviewProvider {
  static var previews: some View {
    MediumView(entry: SimpleEntry(date: Date(), notification: "2021-01-09"))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}
