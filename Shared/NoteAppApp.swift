//
//  NoteAppApp.swift
//  Shared
//
//  Created by Eloo on 8/30/22.
//

import SwiftUI

@main
struct NoteAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
