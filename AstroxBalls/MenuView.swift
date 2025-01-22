//
//  MenuView.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI
import StoreKit

struct MenuView: View {
    @EnvironmentObject private var rewardedViewModel: RewardedViewModel
    @Environment(\.requestReview) var request
    @State var showActions: Bool = false
    @EnvironmentObject private var rootManager: RootManager
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(spacing: 0) {
                        Button {
                            vibrate()
                            showActions = true
                        } label: {
                            Image("plus")
                                .opacity(self.rootManager.lifes == 5 ? 0.5 : 1)
                        }
                        .opacity(rootManager.lifes == 5 ? 0.5 : 1)
                        .disabled(rootManager.lifes == 5)
                        heartPokazateli()
                    }
                    Spacer()
                    VStack(spacing: 0) {
                        Image("plus")
                            .opacity(0)
                        stars()
                    }
                }
                
                HStack {
                    Image("profileImage")
                    
                        .overlay {
                            Image(rootManager.avatarImage)
                                .resizable()
                                .frame(width: 80, height: 102)
                                .offset(y: -11)
                        }
                        .overlay {
                            VStack {
                                Spacer()
                                
                                Text(rootManager.name)
                                    .font(.custom(Font.inter, size: 16))
                                    .foregroundStyle(.white)
                                    .offset(y: -10)
                            }
                        }
                    Spacer()
                    
                    Image("adsReklama")
                        .overlay {
                            VStack {
                                Spacer()
                                
                                buttonWatch()
                            }
                        }
                }
                
                Image("selecRe")
                    .overlay {
                        Text("SELECT GAME")
                            .font(.custom(Font.inter, size: 30))
                            .foregroundStyle(.white)
                    }
                
                HStack {
                    if rootManager.lifes > 0 {
                        NavigationLink {
                            UdariPoPlaneteView()
                        } label: {
                            Image("planetSave")
                                .resizable()
                                .scaledToFit()
                        }
                    } else {
                        Button {
                            vibrate()
                            showActions = true
                        } label: {
                            Image("planetSave")
                                .resizable()
                                .scaledToFit()
                        }
                    }

                      
                    
                    
                    Spacer()
                    
                    
                        NavigationLink {
                            PlinGame()
                        } label: {
                            Image("memory")
                                .resizable()
                                .scaledToFit()
                        }
                   
                    
                   

                }
                .padding(.top)
                
                Button {
                    request()
                   
                } label: {
                    Image("movegm")
                }
                
                
                 
             
                
                Spacer()
            }
            .padding()
            
            if showActions {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        vibrate()
                        showActions = false
                    }
            }
            
            Image("rectaPizd")
                .resizable()
                .frame(width: 270, height: 340)
                .overlay {
                    VStack {
                        HStack {
                            Text("50")
                                .font(.custom(Font.inter, size: 40))
                                .foregroundStyle(.white)
                            
                            Image("star")
                            
                            Text("=")
                                .font(.custom(Font.inter, size: 40))
                                .foregroundStyle(.white)
                            
                            Image("activeh")
                        }
                        
                        Text("or")
                            .font(.custom(Font.inter, size: 40))
                            .foregroundStyle(.white)
                        
                        Button {
                            vibrate()
                            if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                                rewardedViewModel.showAd(from: rootVC)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    showActions = false
                                    rootManager.lifes += 1
                                }
                          
                            } else {
                                print("Failed to get root view controller.")
                            }
                        } label: {
                            Image("adsReklama")
                                .resizable()
                                .frame(width: 88, height: 93)
                                .overlay {
                                    Spacer()
                                    
                                    VStack {
                                        Spacer()
                                        
                                        smallAd()
                                    }
                                }
                                
                        }
                        .opacity(self.rootManager.lifes == 5 ? 0.5 : 1)
                        .disabled(self.rootManager.lifes >= 5)
                        Spacer()
                        
                        Button {
                            vibrate()
                            if rootManager.lifes < 5 {
                                if rootManager.stars >= 50 {
                                    rootManager.stars -= 50
                                    rootManager.lifes += 1
                                    if rootManager.lifes == 5 {
                                        showActions = false
                                    }
                                }
                            }
                        } label: {
                            Image("buyBtn")
                        }

                    }
                    .padding(.vertical)
                }
                .opacity(showActions ? 1 : 0)
                .offset(x: !showActions ? -UIScreen.main.bounds.width : 0)
                .animation(Animation.bouncy, value: showActions)
        }
    }
    
    func buttonWatch() -> some View {
        Button {
            
                if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                    rewardedViewModel.showAd(from: rootVC)
                    rootManager.lifes += 1
                } else {
                    print("Failed to get root view controller.")
                }
    } label: {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(colors: [Color.init(hex: "#3D2C98"), Color.init(hex: "#C548FD")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [Color.init(hex: "#C886F0"), Color.init(hex: "#DC93FD")], startPoint: .topLeading, endPoint: .bottomTrailing),lineWidth: 2.5)
                
                Text("WATCH")
                    .font(.custom(Font.inter, size: 15))
                    .foregroundStyle(.white)
            }
            
    }
    .frame(width: 76, height: 23)
    .opacity(self.rootManager.lifes == 5 ? 0.5 : 1)
    .disabled(self.rootManager.lifes == 5)
    
}
        
    func smallAd() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(colors: [Color.init(hex: "#3D2C98"), Color.init(hex: "#C548FD")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [Color.init(hex: "#C886F0"), Color.init(hex: "#DC93FD")], startPoint: .topLeading, endPoint: .bottomTrailing),lineWidth: 2.5)
                
                Text("WATCH")
                    .font(.custom(Font.inter, size: 10))
                    .foregroundStyle(.white)
            }
            .frame(width: 54, height: 17)
    }
    func heartPokazateli() -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(LinearGradient(colors: [Color.init(hex: "#43466E"), Color.init(hex: "#585E81")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                HStack(spacing: 0) {
                    ForEach(1..<6, id: \.self) { number in
                        Image(rootManager.lifes < number ? "inactiveh" : "activeh")
                    }
                }
            }
            .frame(width: 134, height: 35)
    }
    
    func stars() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(colors: [Color.init(hex: "#43466E"), Color.init(hex: "#585E81")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                HStack(spacing: 10) {
                    Text(String(rootManager.stars))
                        .font(.custom(Font.inter, size: 20))
                        .foregroundStyle(.white)
                    
                    Image("star")
                }
            }
            .frame(width: 107, height: 34)
    }
}


struct PurpleButton: View {
    let width: CGFloat
    let height: CGFloat
    let text: String
    let textSize: CGFloat
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [Color.init(hex: "#3D2C98"), Color.init(hex: "#C548FD")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(colors: [Color.init(hex: "#C886F0"), Color.init(hex: "#DC93FD")], startPoint: .topLeading, endPoint: .bottomTrailing),lineWidth: 2.5)
                    
                    Text(text)
                        .font(.custom(Font.inter, size: textSize))
                        .foregroundStyle(.white)
                }
                .frame(width: width, height: height)
        }

        
    }
}
