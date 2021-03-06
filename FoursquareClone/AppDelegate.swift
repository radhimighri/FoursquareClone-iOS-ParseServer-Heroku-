//
//  AppDelegate.swift
//  FoursquareClone
//
//  Created by Radhi Mighri on 14/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // configuration of using Parse code in Heroku
        let parseConfig = ParseClientConfiguration { (ParseMutableClientConfiguration) in
            // accessing Heroku App via ID & Key
            ParseMutableClientConfiguration.applicationId = "YOUR_APP_ID"
            ParseMutableClientConfiguration.clientKey = "YOUR_CLIENT_KEY"
            ParseMutableClientConfiguration.server = "YOUR_APP_Server_URL"
        }
        
        Parse.initialize(with: parseConfig)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // just to test the connection to the Parse server
//func saveInstallationObject(){
//    if let installation = PFInstallation.current(){
//        installation.saveInBackground {
//            (success: Bool, error: Error?) in
//            if (success) {
//                print("DEBUG: You have successfully connected your app to Back4App!")
//            } else {
//                if let myError = error{
//                    print(myError.localizedDescription)
//                }else{
//                    print("DEBUG: Uknown error")
//                }
//            }
//        }
//    }
//}

}

