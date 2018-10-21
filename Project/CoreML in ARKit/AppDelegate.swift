//
//  AppDelegate.swift
//  CoreML in ARKit
//
//  Created by Hanley Weng on 14/7/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import UIKit
import Alamofire

struct food {
    var name:String = ""
    var code:String = ""
    
    var dairyFree:Bool = false
    var eggFree:Bool = false
    var glutenFree:Bool = false
    var sugarFree:Bool = false
    var caffeineContent:Int = 0
    var nutsFree:Bool = false
    var soyFree:Bool = false
    var fatContent:Int = 0
}

var bananaContents = food()
var muffinContents = food()
var CocaColaContents = food()
var MandMContents = food()
var YogurtContents = food()
var CafeMochaContents = food()

let codes: [String] = ["5bcb5c02ca5fd9ccfa0edc47","5bcb5e59ca5fd9ccfa0edc4a","5bcb6112ca5fd9ccfa0edc4d", "5bcc664977698bdd0e5e41e1", "5bcc620677698bdd0e5e41df", "5bcc647d77698bdd0e5e41e0"
]

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func conditionConversion(number:String) -> Bool{
        if number == "false"{
            return false
        } else {
            return true
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let url = "https://spot-220015.appspot.com/api/items/find/"
        var code:String = codes[0]
        Alamofire.request(url + code).responseJSON{
            response in if response.result.isSuccess {
                if let a:NSDictionary = response.result.value as! NSDictionary{
                    var aOne:NSDictionary = a["obj"] as! NSDictionary
                    var name:String = aOne["name"] as! String
                    aOne = aOne["meta"] as! NSDictionary
                    print(aOne)
                    var dairyFree:String = aOne["dairy-free"] as! String
                    var eggFree:String = aOne["egg-free"] as! String
                    var glutenFree:String = aOne["gluten-free"] as! String
                    var sugarLeast:String = aOne["sugar-free"] as! String
                    var nutsFree:String = aOne["nuts-free"] as! String
                    var caffeineContent:String = aOne["caffeine"] as! String
                    var fatContent:String = aOne["total-fat"] as! String
                    CafeMochaContents.fatContent = (fatContent as NSString).integerValue
                    CafeMochaContents.caffeineContent = (caffeineContent as NSString).integerValue
                    CafeMochaContents.dairyFree = self.conditionConversion(number:dairyFree)
                    CafeMochaContents.eggFree = self.conditionConversion(number:eggFree)
                    CafeMochaContents.glutenFree = self.conditionConversion(number:glutenFree)
                    CafeMochaContents.nutsFree = self.conditionConversion(number:nutsFree)
                    CafeMochaContents.sugarFree = self.conditionConversion(number:sugarLeast)
                }
            }
            code = codes[1]
            Alamofire.request(url + code).responseJSON{
                res in if res.result.isSuccess {
                    if let b:NSDictionary = res.result.value as! NSDictionary{
                        var bOne:NSDictionary = b["obj"] as! NSDictionary
                        var name:String = bOne["name"] as! String
                        bOne = bOne["meta"] as! NSDictionary
                        print(bOne)
                        var dairyFree:String = bOne["dairy-free"] as! String
                        var eggFree:String = bOne["egg-free"] as! String
                        var glutenFree:String = bOne["gluten-free"] as! String
                        var sugarLeast:String = bOne["sugar-free"] as! String
                        var nutsFree:String = bOne["nuts-free"] as! String
                        var caffeineContent:String = bOne["caffeine"] as! String
                        var fatContent:String = bOne["total-fat"] as! String
                        CocaColaContents.fatContent = (fatContent as NSString).integerValue
                        CocaColaContents.caffeineContent = (caffeineContent as NSString).integerValue
                        CocaColaContents.dairyFree = self.conditionConversion(number:dairyFree)
                        CocaColaContents.eggFree = self.conditionConversion(number:eggFree)
                        CocaColaContents.glutenFree = self.conditionConversion(number:glutenFree)
                        CocaColaContents.nutsFree = self.conditionConversion(number:nutsFree)
                        CocaColaContents.sugarFree = self.conditionConversion(number:sugarLeast)
                    }
                }
                code = codes[2]
                Alamofire.request(url + code).responseJSON{
                    r in if r.result.isSuccess {
                        if let c:NSDictionary = r.result.value as! NSDictionary{
                            var cOne:NSDictionary = c["obj"] as! NSDictionary
                            var name:String = cOne["name"] as! String
                            cOne = cOne["meta"] as! NSDictionary
                            print(cOne)
                            var dairyFree:String = cOne["dairy-free"] as! String
                            var eggFree:String = cOne["egg-free"] as! String
                            var glutenFree:String = cOne["gluten-free"] as! String
                            var sugarLeast:String = cOne["sugar-free"] as! String
                            var nutsFree:String = cOne["nuts-free"] as! String
                            var caffeineContent:String = cOne["caffeine"] as! String
                            var fatContent:String = cOne["total-fat"] as! String
                            muffinContents.fatContent = (fatContent as NSString).integerValue
                            muffinContents.caffeineContent = (caffeineContent as NSString).integerValue
                            muffinContents.dairyFree = self.conditionConversion(number:dairyFree)
                            muffinContents.eggFree = self.conditionConversion(number:eggFree)
                            muffinContents.glutenFree = self.conditionConversion(number:glutenFree)
                            muffinContents.nutsFree = self.conditionConversion(number:nutsFree)
                            muffinContents.sugarFree = self.conditionConversion(number:sugarLeast)
                        }
                    }
                    code = codes[3]
                    Alamofire.request(url + code).responseJSON{
                        RES in if RES.result.isSuccess {
                            if let d:NSDictionary = RES.result.value as! NSDictionary{
                                var dOne:NSDictionary = d["obj"] as! NSDictionary
                                var name:String = dOne["name"] as! String
                                dOne = dOne["meta"] as! NSDictionary
                                print(dOne)
                                var dairyFree:String = dOne["dairy-free"] as! String
                                var eggFree:String = dOne["egg-free"] as! String
                                var glutenFree:String = dOne["gluten-free"] as! String
                                var sugarLeast:String = dOne["sugar-free"] as! String
                                var nutsFree:String = dOne["nuts-free"] as! String
                                var caffeineContent:String = dOne["caffeine"] as! String
                                var fatContent:String = dOne["total-fat"] as! String
                                MandMContents.fatContent = (fatContent as NSString).integerValue
                                MandMContents.caffeineContent = (caffeineContent as NSString).integerValue
                                MandMContents.dairyFree = self.conditionConversion(number:dairyFree)
                                MandMContents.eggFree = self.conditionConversion(number:eggFree)
                                MandMContents.glutenFree = self.conditionConversion(number:glutenFree)
                                MandMContents.nutsFree = self.conditionConversion(number:nutsFree)
                                MandMContents.sugarFree = self.conditionConversion(number:sugarLeast)
                            }
                        }
                        code = codes[4]
                        Alamofire.request(url + code).responseJSON{
                            resp in if resp.result.isSuccess {
                                if let e:NSDictionary = resp.result.value as! NSDictionary{
                                    var eOne:NSDictionary = e["obj"] as! NSDictionary
                                    var name:String = eOne["name"] as! String
                                    eOne = eOne["meta"] as! NSDictionary
                                    print(eOne)
                                    var dairyFree:String = eOne["dairy-free"] as! String
                                    var eggFree:String = eOne["egg-free"] as! String
                                    var glutenFree:String = eOne["gluten-free"] as! String
                                    var sugarLeast:String = eOne["sugar-free"] as! String
                                    var nutsFree:String = eOne["nuts-free"] as! String
                                    var caffeineContent:String = eOne["caffeine"] as! String
                                    var fatContent:String = eOne["total-fat"] as! String
                                    bananaContents.fatContent = (fatContent as NSString).integerValue
                                    bananaContents.caffeineContent = (caffeineContent as NSString).integerValue
                                    bananaContents.dairyFree = self.conditionConversion(number:dairyFree)
                                    bananaContents.eggFree = self.conditionConversion(number:eggFree)
                                    bananaContents.glutenFree = self.conditionConversion(number:glutenFree)
                                    bananaContents.nutsFree = self.conditionConversion(number:nutsFree)
                                    bananaContents.sugarFree = self.conditionConversion(number:sugarLeast)
                                }
                            }
                        }
                        code = codes[5]
                        Alamofire.request(url + code).responseJSON{
                            respo in if respo.result.isSuccess {
                                if let f:NSDictionary = respo.result.value as! NSDictionary{
                                    var fOne:NSDictionary = f["obj"] as! NSDictionary
                                    var name:String = fOne["name"] as! String
                                    fOne = fOne["meta"] as! NSDictionary
                                    print(fOne)
                                    var dairyFree:String = fOne["dairy-free"] as! String
                                    var eggFree:String = fOne["egg-free"] as! String
                                    var glutenFree:String = fOne["gluten-free"] as! String
                                    var sugarLeast:String = fOne["sugar-free"] as! String
                                    var nutsFree:String = fOne["nuts-free"] as! String
                                    var caffeineContent:String = fOne["caffeine"] as! String
                                    var fatContent:String = fOne["total-fat"] as! String
                                    YogurtContents.fatContent = (fatContent as NSString).integerValue
                                    YogurtContents.caffeineContent = (caffeineContent as NSString).integerValue
                                    YogurtContents.dairyFree = self.conditionConversion(number:dairyFree)
                                    YogurtContents.eggFree = self.conditionConversion(number:eggFree)
                                    YogurtContents.glutenFree = self.conditionConversion(number:glutenFree)
                                    YogurtContents.nutsFree = self.conditionConversion(number:nutsFree)
                                    YogurtContents.sugarFree = self.conditionConversion(number:sugarLeast)
                                }
                            }
                        }
                    }
                }
            }
        }
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

