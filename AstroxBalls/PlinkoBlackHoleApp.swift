//
//  PlinkoBlackHoleApp.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 29/11/2024.
//

import SwiftUI

@main
struct PlinkoBlackHoleApp: App {
    @StateObject private var rootManager: RootManager = RootManager()
    @StateObject private var rewardedModel: RewardedViewModel = RewardedViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView()
            }
            .environmentObject(rootManager)
            .environmentObject(rewardedModel)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
