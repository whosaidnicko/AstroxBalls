//
//  GonkaMeciLevels.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 19/01/2025.
//


import SwiftUI


struct GonkaMeciLevels: View {
    @Environment(\.dismiss) var dismiss
    @State var levelSelected: Int = 0
    @State var timer: Timer?
    @State var itemsMov: [MovingIv] = []
    @State var gameStart: Bool = false
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack  {
            Color.init(hex: "#1A0033")
                .ignoresSafeArea()
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 25, height: UIScreen
                    .main.bounds.height)
                .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height / 2)
                .ignoresSafeArea()
                .scaleEffect(gameStart ? 1 : 0)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 25, height: UIScreen
                    .main.bounds.height)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                .ignoresSafeArea()
            
                .scaleEffect(gameStart ? 1 : 0)
            
            
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 25, height: UIScreen
                    .main.bounds.height)
                .position(x: 50, y: UIScreen.main.bounds.height / 2)
                .ignoresSafeArea()
                .scaleEffect(gameStart ? 1 : 0)
            if gameStart {
                MovingIv(x: UIScreen.main.bounds.width / 2, seconds: Double.random(in: 0.4...1))
                
                ForEach(itemsMov.indices, id: \.self) { index in
                    itemsMov[index]
                }
            }
            VStack {
                HStack {
                    BackBTNView() {
                        dismiss()
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                Group {
                    if !gameStart {
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 30) {
                                ForEach(1..<11) { number in
                                    Button {
                                        gameStart = true
                                        levelSelected = number
                                        timer = Timer.scheduledTimer(withTimeInterval: 5 - ( 1 - (Double(number) / 10)), repeats: true) { _ in
                                            itemsMov.append(MovingIv(x: Bool.random() ? UIScreen.main.bounds.width / 2 : Bool.random() ? UIScreen.main.bounds.width - 50 : UIScreen.main.bounds.width + 50 , seconds: Double.random(in: 0.25...1-(Double(levelSelected / 10)))))
                                        }
                                    } label: {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(UserDefaults.standard.string(forKey: String(number).appending("m")) == nil ? Color.init(hex: "#282844") : Color.init(hex: "#29C352"))
                                            .frame(width: 112, height: 108)
                                            .overlay {
                                                Text(String(number))
                                                    .font(.custom(Font.inter, size: 40))
                                                    .foregroundStyle(.white)
                                            }
                                    }
                                    .disabled(UserDefaults.standard.string(forKey: String(number).appending("m")) == nil)
                                    
                                }
                            }
                        }
                    }
                }
                .transition(.scale)
                .animation(Animation.easeOut, value: gameStart)
                Spacer()
            }
            
            
        }
        .navigationBarBackButtonHidden()
        .onAppear() {
            UserDefaults.standard.set("s", forKey: "1m")
        }
    }
}
