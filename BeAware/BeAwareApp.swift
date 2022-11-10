//
//  BeAwareApp.swift
//  BeAware
//
//  Created by Hitesh Parikh on 2/2/22.
//
import AppCenterAnalytics
import AppCenterCrashes
import SwiftUI

@main
struct BeAwareApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init(){
        AppCenter.start(withAppSecret: "{Your App Secret}", services: [Analytics.self, Crashes.self])
        if Crashes.hasCrashedInLastSession{
            let crashReport = Crashes.lastSessionCrashReport
            var props : [String:String]? // Dictionary var myDictionary:[String:Int] = ["Mohan":75, "Raghu":82, "John":79] myDictionary["Surya"] = 88
            props = ["appVersion": crashReport?.device?.appVersion ?? "?",
                     "locale": crashReport?.device?.locale ?? "?",
                     "country": crashReport?.device?.carrierCountry ?? "?",
                     "osName": crashReport?.device?.osName ?? "?",
                     "model": crashReport?.device?.model ?? "?",
                     "description": crashReport?.description ?? "?",
                     "debug": crashReport?.debugDescription ?? "?",
                     "name": crashReport?.exceptionName ?? "?",
                     "reason": crashReport?.exceptionReason ?? "?"]
            Analytics.trackEvent("AppCrashedInLastLaunch: ", withProperties: props, flags: .critical)
        }
    }
    var body: some Scene {
        WindowGroup {
            IntroductionView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
        
    static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
