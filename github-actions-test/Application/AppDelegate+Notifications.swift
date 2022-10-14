//
//  AppDelegate+Notifications.swift
//  kapida
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import Localize_Swift
import FirebaseDynamicLinks

// MARK: - Push Notifications
extension AppDelegate {
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        log("didRegisterForRemoteNotificationsWithDeviceToken Token: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        log("didFailToRegisterForRemoteNotificationsWithError Error: \(error)")
    }

    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        guard let payload = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        // Handle your payload
        log("didReceiveRemoteNotification:\n\(payload)")
        completionHandler(.newData)
    }


    func registerForPushNotifications(_ application: UIApplication = UIApplication.shared) {
        Messaging.messaging().delegate = self
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(
            options: options) { [weak self] granted, error in
            if let error = error {
                // Handle the error here.
                log("registerForPushNotifications - Error: \(error)")
            }

            // Enable or disable features based on the authorization.
            log("registerForPushNotifications - Granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
        }
        application.registerForRemoteNotifications()

        Messaging.messaging().token { token, error in
            if let error = error {
                log("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                log("FCM registration token: \(token)")
                log("Remote FCM registration token: \(token)")
            }
        }

        Messaging.messaging().subscribe(toTopic: "Kapida") { _ in
            log("Subscribed to \("Kapida") topic")
        }
    }

    func getNotificationSettings() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            log("getNotificationSettings: \(settings)")
            UserDefaults.standard.isSystemNotificationSettingsGranted = settings.authorizationStatus == .authorized
        }
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        // handleDeeplinkPush(userInfo)
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        log("Firebase registration token: \(fcmToken ?? "")")
    }
}
