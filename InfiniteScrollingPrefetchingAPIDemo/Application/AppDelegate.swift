//
//  AppDelegate.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 25/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    setStatusBar()
    setNavigationBar()
    return true
  }
}


// MARK: - Set style
private extension AppDelegate {
  
  func setStatusBar() {
    UIApplication.shared.statusBarStyle = .default
  }
  
  func setNavigationBar() {
    UINavigationBar.appearance().tintColor = UIColor.mint
  }
  
}
