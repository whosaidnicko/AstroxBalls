//
//  ThisViewPresented.swift
//  PlinkoBlackHole
//
//  Created by Nicolae Chivriga on 29/11/2024.
//



enum ThisViewPresented {
    case loading
    case newPlayer
    case settings
    case udariPoPlanete
    case memorizeBalls
    case pianino
    case menu
    
    var imageBackground: String {
        switch self {
        case .menu, .settings, .newPlayer:
            ConstantsFiles.Images.menuBackground
        default: ConstantsFiles.Images.cosmosBackground
        }
    }
}
