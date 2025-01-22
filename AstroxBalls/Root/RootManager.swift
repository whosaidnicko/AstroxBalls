//
//  RootManager.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 29/11/2024.
//

import SwiftUI


final class RootManager: ObservableObject {
    @Published var thisViewPresented: ThisViewPresented = .loading
    @AppStorage("avatarImage") var avatarImage: String = ""
    @AppStorage("lifes") var  lifes: Int = 3
    @AppStorage("name") var name: String = ""
    @AppStorage("stars") var stars: Int = 250
    
}
