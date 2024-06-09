//
//  AppDelegate.swift
//  Sahmak
//
//  Created by mac on 08/04/2023.
//

import UIKit
import MOLH
import IQKeyboardManagerSwift
import Firebase
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        MOLHLanguage.setDefaultLanguage("ar")
        GMSServices.provideAPIKey("AIzaSyCc4MToS27ZuJQr7vwg90ae2yzYYGqywlo")
        MOLH.shared.activate(true)

        setupKeyboardManager()
        redirectToHome()
        
        configureApp(application)
        return true
    }
    
    public func redirectToHome() {
        let token = K_Defaults.string(forKey: Saved.TOKEN) ?? ""
        if token.isEmpty {
            let vc = SignInVC.loadFromNib()
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"tabController")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard let url = userActivity.webpageURL else { return false}
        _ = url.pathComponents[1]
        _ = url.pathComponents[2]
        guard UIApplication.topViewController() != nil else { return false}
        return true
    }
}

extension AppDelegate: MOLHResetable {
    func reset() {
        redirectToHome()
    }
}


extension AppDelegate {
    
    func configureApp(_ application: UIApplication) {
        configAppSetting()
        configureAppAppearance()
        configureIQKeyboardAppearance()
        FirebaseApp.configure()
        registerNotification(application)
        application.applicationIconBadgeNumber = 0
    }
   
    func configureIQKeyboardAppearance() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldPlayInputClicks = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = false
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
    }
    
    func configureAppAppearance() {
        DispatchQueue.main.async {
            self.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    
    func configAppSetting() {
        configureAppAppearance()
//        window?.backgroundColor = .ctPrimaryBG
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
       // UIImageView.appearance().backgroundColor = .ctPrimary
//        UITableView.appearance().backgroundColor = .ctPrimaryBG
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
    }
}


extension AppDelegate {
    
    func registerNotification(_ application: UIApplication) {
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmToken", fcmToken ?? "")
        K_Defaults.set(fcmToken ?? "", forKey: Saved.FCM_TOKEN)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToken", deviceToken)
        K_Defaults.set(deviceToken, forKey: Saved.DEVICE_TOKEN)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("[AppDelegate] Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        if let type = userInfo["gcm.notification.type"] {
            print("type: \(type)")
        }
        print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Swift.Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        if let type = userInfo["gcm.notification.type"] {
            print("type: \(type)")
        }
        print(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
   
}
