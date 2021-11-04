//
//  AppDelegate.swift
//  RadioPlayer
//
//  Created by Adem Özcan on 18.10.2021.
//

import Foundation
import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.beginReceivingRemoteControlEvents()
        return true
    }
}
