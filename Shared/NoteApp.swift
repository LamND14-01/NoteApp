//
//  NoteApp.swift
//  Shared
//
//  Created by Eloo on 8/30/22.
//

import SwiftUI
import FirebaseCore
import UserNotifications

@main
struct NoteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        requestAuthorization()
        
        return true
    }
    
    private func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .badge, .sound]) { isSuccess, error in
                    if let error = error {
                        print("\(error.localizedDescription)")
                    }
                    if isSuccess {
                        self.scheduleNotifization()
                    }
                }
            case .authorized, .provisional:
                self.scheduleNotifization()
            default:
                break
            }
        }
    }
    
    private func scheduleNotifization() {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            let identifers = requests.map { $0.identifier }
            if !identifers.contains(Constant.weeklyNotifization) {
                self.schedule()
            }
        })
    }
    
    private func schedule() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Check today's task"
        content.subtitle = "Plan for a productive week"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = 2
        dateComponents.hour = 9

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let requsest = UNNotificationRequest(identifier: Constant.weeklyNotifization, content: content, trigger: trigger)
        center.add(requsest)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let id = response.notification.request.identifier
        print("Received notification with ID = \(id)")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let id = notification.request.identifier
        print("Received notification with ID = \(id)")
        completionHandler([.sound, .badge])
    }
}
