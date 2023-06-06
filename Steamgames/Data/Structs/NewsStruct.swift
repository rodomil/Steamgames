//
//  NewsStruct.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import Foundation

struct NewsStruct: Codable {
    let appnews: NewsId
}

struct NewsId: Codable {
    let newsitems: [OnceNews]
}

struct OnceNews: Codable {
    let title: String
    let url: String
    let author: String
    let contents: String
    let date: Int
}
