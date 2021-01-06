//
//  Billbook_SwfitApp.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI
import os

@main
struct Billbook_SwfitApp: App {
  
  @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
  
  @StateObject private var enObj = EnObj()
  
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(enObj)
        .onAppear{
          if (UserDefaults.standard.string(forKey: "Username") != nil) {
            enObj.enLoggedIn = true
            enObj.enUsername = UserDefaults.standard.string(forKey: "Username")!
            AuthCheck().authCheck(enObj: enObj)
          }
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (allowed, error) in
            //This callback does not trigger on main loop be careful
            if allowed {
              os_log(.debug, "Allowed: \(allowed)")
              
            } else {
              os_log(.debug, "Error")
            }
          }
        }
    }
  }
}




// ********** TEST STARTS **********
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UIApplication.shared.registerForRemoteNotifications()
    UNUserNotificationCenter.current().delegate = self
    return true
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Remote notification is unavailable: \(error.localizedDescription)")
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("***Device Token:\(deviceToken)")
    self.forwardTokenToServer(token: deviceToken)
  }
  
  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      // Called when a new scene session is being created.
      // Use this method to select a configuration to create the new scene with.
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication,
                   didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      // Called when the user discards a scene session.
      // If any sessions were discarded while the application was not running,
      // this will be called shortly after application:didFinishLaunchingWithOptions.
      // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  // 635a43f863c759284e16b5b5dee39a2329e34d7732f03351d4d64b96edc4f0c4
  
  func forwardTokenToServer(token: Data) {
    let tokenComponents = token.map { data in String(format: "%02.2hhx", data) }
    let deviceTokenString = tokenComponents.joined()
    print("***Device Token:\(deviceTokenString)")
    
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/apns/post/")
    else { print("Invalid URL"); return }
    let body: [String: String] = ["username": "Billbook", "apnsToken": deviceTokenString, "environment": "dev"]
    let codededBody = try! JSONSerialization.data(withJSONObject: body)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = codededBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.dataTask(with: request) { (data, resp, error) in
      if let data = data {
        let dataString = String(decoding: data, as: UTF8.self)
        print("***Response: ", dataString)
        return
      }
      print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
    
//    let queryItems = [URLQueryItem(name: "username", value: "billbook"), URLQueryItem(name: "apnsToken", value: deviceTokenString), URLQueryItem(name: "environment", value: "dev")]
//    var urlComps = URLComponents(string: "https://vzw.api.we0mmm.site/api/v1/apnstoken/post/")!
//    urlComps.queryItems = queryItems
//    guard let url = urlComps.url else {
//      return
//    }
//
//    let task = URLSession.shared.dataTask(with: url) { data, resp, error in
//      if error != nil {
//          // Handle the error
//          return
//      }
//      guard resp != nil else {
//          // Handle empty response
//          return
//      }
//      guard data != nil else {
//          // Handle empty data
//          return
//      }
//    }
//    task.resume()
  }
  
  /* Example Payload
   {
       "aps" : {
          "alert" : {
               "title" : "Check out our new special!",
               "body" : "Avocado Bacon Burger on sale"
           },
           "sound" : "default",
           "badge" : 1,
      },
       "special" : "avocado_bacon_burger",
       "price" : "9.99"
   }
   */
  
  @IBAction func subscribeToNotifications(_ sender: Any) {
    let userNotificationCenter = UNUserNotificationCenter.current()
    userNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      print("Permission granted: \(granted)")
    }
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    guard let specialName = userInfo["spcial"] as? String,
          let specialPriceString = userInfo["price"] as? String,
          let specialPrice = Float(specialPriceString) else {
      // Always call the completion handler when done.
      completionHandler()
      return
    }
    
    // Opening this alert will start purchasing the item in a real app.
    let item = Item(name: specialName, price: specialPrice)
    addItemToCart(item)
    showCartViewController()

    // Always call the completion handler when done.
    completionHandler()
  }
  func addItemToCart(_ item: Item) {
      // Add the item to the cart in response to a notification tap
      // so the user can purchase that item.
  }

  func showCartViewController() {
      // Show the cart so the application is in the proper state
      // after opening a notification.
  }
  
}
// ########## TEST ENDS ##########





//*** Implement App delegate ***//
//class AppDelegate: NSObject, UIApplicationDelegate {
//
//
//
//  func getNotificationSettings() {
//    UNUserNotificationCenter.current().getNotificationSettings { settings in
//      print("Notification settings: \(settings)")
//    }
//  }
//
//  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    return true
//  }
//  //No callback in simulator
//  //-- must use device to get valid push token
//  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)          {
//    print("******",deviceToken)
//  }
//  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//    print("Register Fail: ", error.localizedDescription)
//  }
//
//
//}
