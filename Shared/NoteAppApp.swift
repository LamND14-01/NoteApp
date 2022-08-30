//
//  NoteAppApp.swift
//  Shared
//
//  Created by Eloo on 8/30/22.
//

import SwiftUI
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@main
struct NoteAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppCenter.start(withAppSecret: "700dbc04-84b9-41d0-89f3-a29b0fca2fc6", services: [
            Analytics.self,
            Crashes.self
        ])
        
        return true
    }
}
