//
//  UdariPoPlaneteView.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI
import Lottie


struct UdariPoPlaneteView: View {
    @EnvironmentObject private var rootManager: RootManager
    @State var currentScore: Int = 0 {
        didSet {
            if currentScore == recordCurrent {
                numbers = 0
                timer?.invalidate()
                win = true
            }
        }
    }
    @AppStorage("recordCurrent") var recordCurrent: Int = 12
    @State private var planetPosition: CGPoint = .zero
    @State var timer: Timer?
    @State var numbers: Int = 1
    @State var startsGame: Bool = false
    @State var win: Bool?
    @State var sdelaiBoom: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Image(ConstantsFiles.Images.cosmosBackground)
                .resizable()
                .ignoresSafeArea()
            VStack {
                BackBTNView() {
                    dismiss()
                    startsGame = false
                }
                .padding([.top, .horizontal])
                if !startsGame {
                    Image("rectaPizd")
                        .overlay {
                            VStack {
                                Text("Protect our planet from asteroids")
                                    .font(.custom(Font.inter, size: 40))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                
                                
                                PurpleButton(width: 216, height: 69, text: "START", textSize: 41) {
                                    startsGame = true
                                    timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { time in
                                        if Bool.random() {
                                            if Bool.random() {
                                                numbers += 1
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    
                        .padding(.top, 90)
                }
                else {
                    Image("pokazateli")
                        .overlay {
                            ZStack {
                                ZStack() {
                                    Text(String(recordCurrent - 8))
                                        .font(.custom(Font.inter, size: 20))
                                        .foregroundStyle(.white)
                                        .offset(y: -44)
                                    
                                    Image("greenBall")
                                        .scaleEffect(currentScore >= (recordCurrent - 8) ? 1 : 0)
                                }
                                .offset(x: -93)
                                
                                ZStack {
                                    Text(String(recordCurrent - 4))
                                        .font(.custom(Font.inter, size: 20))
                                        .foregroundStyle(.white)
                                        .offset(y: -44)
                                    
                                    Image("greenBall")
                                        .scaleEffect(currentScore >= (recordCurrent - 4) ? 1 : 0)
                                }
                                
                                ZStack {
                                    Text(String(recordCurrent ))
                                        .font(.custom(Font.inter, size: 20))
                                        .foregroundStyle(.white)
                                        .offset(y: -44)
                                    
                                    Image("greenBall")
                                        .scaleEffect(currentScore >= recordCurrent ? 1 : 0)
                                }
                                .offset(x: 93)
                            }
                            
                        }
                        .animation(Animation.bouncy, value: currentScore)
                }
                
               
                Spacer()
                
                if startsGame  {
                    if sdelaiBoom {
                        LottieView(animation: .named("planetBomba"))
                        .playing(.fromFrame(1, toFrame: 5, loopMode: .playOnce))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 275)
                    } else {
                        Image("plen")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: 275)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            let frame = geometry.frame(in: .global)
                                            planetPosition = CGPoint(x: frame.midX, y: frame.minY - 70)
                                            
                                        }
                                }
                            )
                    }
                }
                    
            }
            .ignoresSafeArea( edges: .bottom)
            
            if startsGame {
                ForEach(0..<numbers, id: \.self) { _ in
                    MeteoritiEbashat(position: $planetPosition, resultWin: $win) {
                        sdelaiBoom = true
                        withAnimation {
                            win = false
                        }
                        vibrate()
                        timer?.invalidate()
                        numbers = 0
                    } tapedAction:  {
                        currentScore += 1
                    }
                }
            }
            
            if win != nil {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
            }
            
            winLeibl()
                .offset(x: win == nil ? -UIScreen.main
                    .bounds.width : 0)
                .animation(Animation.bouncy, value: win)
        }
        .navigationBarBackButtonHidden()
       
    }
    @ViewBuilder
    func winLeibl() -> some View {
        if win != nil {
            Image(win! ? "winre" : "lostL")
                .resizable()
                .frame(width: 340, height: 330)
                .overlay {
                    VStack {
                        if win! {
                            Image("stars")
                                .resizable()
                                .frame(width: 170, height: 120)
                                .padding(.top, 80)
                            
                            
                            let randomNumber = Int.random(in: 25...50)
                            Text(String(randomNumber))
                                .font(.custom(Font.inter, size: 59))
                                .foregroundStyle(.white)
                                .onAppear() {
                                    self.rootManager.stars += randomNumber
                                }
                            
                            Spacer()
                            
                            PurpleButton(width: 200, height: 40, text: "MENU", textSize: 40) {
                                recordCurrent += 4
                                dismiss()
                            }
                            .padding(.bottom, 30)
                        } else {
                            VStack {
                                HearthPokazateli()
                                    .onAppear() {
                                        withAnimation(Animation.easeInOut(duration: 2)) {
                                            rootManager.lifes -= 1
                                        }
                                    }
                                
                                PurpleButton(width: 200, height: 40, text: "MENU", textSize: 40) {
                                    dismiss()
                                }
                                .padding(.top, 30)
                            }
                        }
                    }
                }
               
        }
    }
}
