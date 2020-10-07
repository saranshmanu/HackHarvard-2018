//
//  AppDelegate.swift
//  CoreML in ARKit
//
//  Created by Hanley Weng on 14/7/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        filters = [
            Filter(name: "CAFFEINE", image: "Caffeine", positive: "Least Caffeine Content", negative: "Contains Caffeine"),
            Filter(name: "DAIRY FREE", image: "DairyFree", positive: "Dairy Free", negative: "Contains Dairy"),
            Filter(name: "EGG FREE", image: "EggFree", positive: "Egg Free", negative: "Contains Egg"),
            Filter(name: "LESS FAT", image: "FatFree", positive: "Least Fat content", negative: "Contains Fat"),
            Filter(name: "GLUTEN FREE", image: "GlutenFree", positive: "Gluten Free", negative: "Contains Gluten"),
            Filter(name: "NUT FREE", image: "NutFree", positive: "Nut Free", negative: "Contains Nut"),
            Filter(name: "SOY FREE", image: "SoyFree", positive: "Soy Free", negative: "Contains Soy"),
            Filter(name: "SUGAR FREE", image: "SugarFree", positive: "Sugar Free", negative: "Contains Sugar")
        ]
        
        products = [
            Product(name: "Banana", code: "5bcb5c02ca5fd9ccfa0edc47"),
            Product(name: "Muffin", code: "5bcb5e59ca5fd9ccfa0edc4a"),
            Product(name: "Coca-Cola", code: "5bcb6112ca5fd9ccfa0edc4d"),
            Product(name: "M&M", code: "5bcc664977698bdd0e5e41e1"),
            Product(name: "Yogurt", code: "5bcc620677698bdd0e5e41df"),
            Product(name: "Cafe Mocha", code: "5bcc647d77698bdd0e5e41e0")
        ]

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

