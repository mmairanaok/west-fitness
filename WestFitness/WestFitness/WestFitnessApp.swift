//
//  WestFitnessApp.swift
//  WestFitness
//
//  Created by Marco Mairana on 12/07/2022.
//

import SwiftUI
import Firebase

@main
struct WestFitnessApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabContainerView()
            } else {
                LandingView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

class AppState: ObservableObject {
    
    @Published private(set) var isLoggedIn = false
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
        //try? Auth.auth().signOut()
        userService.observeAuthChanges()
            .map {$0 != nil }
            .assign(to: &$isLoggedIn)
    }
}
