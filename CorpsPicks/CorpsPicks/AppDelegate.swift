
//
//  AppDelegate.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/22/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Fabric
import Crashlytics
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, FUIAuthDelegate, GIDSignInDelegate, UIApplicationDelegate {

  var window: UIWindow?
  var launched: Bool = false


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Fabric
    Fabric.with([Crashlytics.self])
    
    // Firebase
    FirebaseApp.configure()
    
    // Signout of Firebase
//    try! FIRAuth.auth().signOut()
    
    // Firebase Auth
    let authUI = FUIAuth.defaultAuthUI()
    // You need to adopt a FUIAuthDelegate protocol to receive callback
    authUI?.delegate = self
    
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth(),
        FUIFacebookAuth(),
        ]
    authUI?.providers = providers
    
    // Google Sign-In
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    
    // ToS
    let kFirebaseTermsOfService = URL(string: "https://firebase.google.com/terms/")!
    authUI?.tosurl = kFirebaseTermsOfService
    
    // Present the auth view controller and then implement the sign in callback.
    _ = authUI!.authViewController()
//    self.window?.rootViewController = authViewController
    
    // listen for changes in the authorization state
    _ = FIRAuth.auth().addStateDidChangeListener { (auth: FIRAuth, user: FIRUser?) in
      
      // check if there is a current user
      if user != nil {
        print("Firebase logged in with uid \(user!.uid)")
        CurrentUser.sharedInstance.uid = user!.uid
        if let email = user!.email {
          CurrentUser.sharedInstance.email = email
        }
        if let photoURL = user!.photoURL {
          CurrentUser.sharedInstance.photoURL = photoURL
        }
        UserInterface.setUser()
        self.launchStoryboard(StoryboardName.Main)
      } else {
        // user must sign in
        self.loginSession()
      }
    }
    
    return true
  }
  
  func loginSession() {
    let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
    let rootVc = UIApplication.shared.keyWindow?.rootViewController
    rootVc?.present(authViewController, animated: true, completion: nil)
  }
  
  // FUIAuthDelegate
  func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
    // handle user and error as necessary
    handleSuccessfulLogin()
  }
    
  // Firebase Facebook / Google Auth callback
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
    if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
      handleSuccessfulLogin()
      return true
    }
    // GIDSignIn
    return GIDSignIn.sharedInstance().handle(url,
                                             sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                             annotation: [:])
  }
  
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return GIDSignIn.sharedInstance().handle(url,
                                             sourceApplication: sourceApplication,
                                             annotation: annotation)
  }
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    // ...
    if error != nil {
      // ...
      return
    }
    
    guard let authentication = user.authentication else { return }
    _ = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                      accessToken: authentication.accessToken)
    // ...
  }
  
  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    // Perform any operations when the user disconnects from app here.
    // ...
  }
  
  func handleSuccessfulLogin() {
//    launchStoryboard(StoryboardName.Main)
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func launchStoryboard(_ storyboard: StoryboardName) {
    if (self.launched == true) { return }
    self.launched = true
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    let controller = storyboard.instantiateInitialViewController()! as UIViewController
    self.window?.rootViewController = controller
    
    // Startup code
    StartupService.sharedInstance.start()
    
    // set initial eventIds
//    let contestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Contest") as! ContestView
//        contestVC.eventId = "999999"
  }

}

