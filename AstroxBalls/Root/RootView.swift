//
//  RootView.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 29/11/2024.
//

import SwiftUI


struct RootView: View {
    @EnvironmentObject private var rootManager: RootManager
    @EnvironmentObject private var rewardedModel: RewardedViewModel
    var body: some View {
        ZStack {
            Image(rootManager.thisViewPresented.imageBackground)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Group {
                    switch rootManager.thisViewPresented {
                    case .loading:
                        LoadingView()
                    case .newPlayer:
                        NewPlayerView()
                    case .settings:
                        SettingsView()
                    case .udariPoPlanete:
                        UdariPoPlaneteView()
                    case .memorizeBalls:
                        MemorizeBallsView()
                    case .pianino:
                        PianinoView()
                    case .menu:
                        MenuView()
                    }
                }
                .transition(AnyTransition.scale)
            }
            .animation(Animation.default, value: rootManager.thisViewPresented)
            .onAppear() {
                rewardedModel.loadAd()
            }
           
        }
        .kslea()
       
       
       
    }
}
