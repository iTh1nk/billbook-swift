//
//  VarConfig.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/6/21.
//

import Foundation

struct VarConfig {
  static var APIPrefix = "https://vzw.api.we0mmm.site/api/v1"
  static var APNsTokenForward = VarConfig.APIPrefix + "/apns/post/"
  static var APNsTokenLastUsed = VarConfig.APIPrefix + "/apns/put/"
}
