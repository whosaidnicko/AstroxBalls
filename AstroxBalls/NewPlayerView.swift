//
//  NewPlayerView.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI


struct NewPlayerView: View {
    @EnvironmentObject private var rootManager: RootManager
    @State var showAvatarCase: Bool = false
    @State var textName: String = ""
    @FocusState var keybordActive
    var body: some View {
        VStack {
            Group {
                if showAvatarCase {
                    Image(ConstantsFiles.Images.container)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            VStack {
                                Text("Choose your avatar")
                                    .font(.custom(Font.inter, size: 30))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                                
                                HStack {
                                    Image("1av")
                                        .onTapGesture {
                                            vibrate()
                                           
                                            rootManager.avatarImage = "1av"
                                            rootManager.name = textName
                                            rootManager.thisViewPresented = .menu
                                        }
                                    
                                    
                                    Image("2av")
                                        .onTapGesture {
                                            vibrate()
                                            rootManager.avatarImage = "2av"
                                            rootManager.name = textName
                                            rootManager.thisViewPresented = .menu
                                        }
                                    
                                    Image("3av")
                                        .onTapGesture {
                                            vibrate()
                                            rootManager.avatarImage = "3av"
                                            rootManager.name = textName
                                            rootManager.thisViewPresented = .menu
                                        }
                                }
                                .padding(.top, 90)
                                
                                HStack {
                                    Image("4av")
                                        .onTapGesture {
                                            vibrate()
                                            rootManager.avatarImage = "4av"
                                            rootManager.name = textName
                                            rootManager.thisViewPresented = .menu
                                        }
                                    
                                    Image("5av")
                                        .onTapGesture {
                                            vibrate()
                                            rootManager.avatarImage = "5av"
                                            rootManager.name = textName
                                            rootManager.thisViewPresented = .menu
                                        }
                                    
                                    Image("6av")
                                        .onTapGesture {
                                            vibrate()
                                            rootManager.avatarImage = "6av"
                                            rootManager.name = textName
                                            rootManager.thisViewPresented = .menu
                                        }
                                }
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                } else {
                    Image(ConstantsFiles.Images.container)
                        .resizable()
                        .frame(width: 280, height: 300)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.init(hex: "#282844"))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white
                                                ,lineWidth: 1)
                                    
                                    HStack {
                                        ZStack(alignment: .leading) {
                                            
                                            Text(textName.isEmpty ? "NAME" : textName)
                                                .font(.custom(Font.inter, size: textName.isEmpty ? 30 : 20))
                                                    .foregroundStyle(textName.isEmpty ? Color.init(hex: "#494848") : Color.white)
                                            
                                            TextField("", text: $textName)
                                                .foregroundStyle(.white)
                                                .focused($keybordActive)
                                                .opacity(0)
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        keybordActive = true
                                    }
                                }
                                .frame(width: 203, height: 46)
                        }
                        .onSubmit {
                            if !textName.isEmpty {
                                withAnimation {
                                    showAvatarCase = true
                                }
                            }
                        }
                }
            }
            .transition(.scale)
        }
     
    }
}

func vibrate() {
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
       impactMed.impactOccurred()
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var povernu = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: povernu))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if povernu == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.povernu
    }
}
