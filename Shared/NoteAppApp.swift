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
        AppCenter.start(withAppSecret: "c396551f-d206-4bc6-b3ee-faab68ddff4a", services: [
            Analytics.self,
            Crashes.self
        ])
        return true
    }
}
