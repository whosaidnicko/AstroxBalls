//
//  LoadingView.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI


struct LoadingView: View {
    @EnvironmentObject private var rootManager: RootManager
    @State private var viewPosition: CGPoint = .zero
    @State var animationGoing: Bool = false
    var body: some View {
        VStack {
            
            ZStack {
                ForEach(0..<Int.random(in: 2...5)) { _ in
                    MeteoritView(position: CGPoint(x: viewPosition.x - CGFloat((Int.random(in: 0...100))), y: viewPosition.y - 50))
                }
            }
            .onAppear() {
                withAnimation(Animation.linear(duration: 4)) {
                    animationGoing = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    if !rootManager.avatarImage.isEmpty && !rootManager.name.isEmpty {
                        
                            rootManager.thisViewPresented = .menu
                        
                        
                    } else {
                            rootManager.thisViewPresented = .newPlayer
                        
                    }
                }
            }
                
            Spacer()
            
            VStack(spacing: 0) {
                Text("Loading")
                    .font(.custom(Font.inter, size: 25))
                    .foregroundStyle(.white)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [Color.init(hex: "#21CF46"), Color.init(hex: "#67FF7D")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(colors: [Color.init(hex: "#3D2C98"), Color.init(hex: "#C548FD")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 261 * (animationGoing ? 1 : 0), height: 15)
                    })
                    .frame(width: 261, height: 15)
                
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let frame = geometry.frame(in: .global)
                                    viewPosition = CGPoint(x: frame.midX, y: frame.midY)
                                }
                        }
                    )
                    .frame(width: 200, height: 100)
            }
                
        }
        .ignoresSafeArea()
        
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
