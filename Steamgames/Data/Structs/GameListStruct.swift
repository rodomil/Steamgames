//
//  GameListStruct.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import Foundation

struct GameListStruct: Codable {
    let applist: GameAppListStruct
}

struct GameAppListStruct: Codable {
    let apps: [GameOneStruct]
}

struct GameOneStruct: Codable {
    let appid: Int
    let name: String
}

