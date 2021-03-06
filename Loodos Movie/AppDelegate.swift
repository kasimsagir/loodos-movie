//
//  AppDelegate.swift
//  Loodos Movie
//
//  Created by Kasım on 17.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit
import Firebase
import PKHUD
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        let _ = RCValues.shared

        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        
        return true
    }

    // ** APNS - Sertifikam olmadığından test edemedim ve devamını getiremedim **
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })

        application.registerForRemoteNotifications()
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
}
