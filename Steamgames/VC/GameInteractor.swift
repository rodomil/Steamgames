//
//  GameInteractor.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import Foundation

protocol GameListProtocol: AnyObject {
    func gameList(data: [GameOneStruct])
    func news(data: [OnceNews])
}
extension GameListProtocol {
    func gameList(data: [GameOneStruct]) {}
    func news(data: [OnceNews]) {}
}

final class GameInteractor {
    
    weak var delegateGameList: GameListProtocol?
    
    func loadGameList() {
        APIManager.loadDataGET(structData: GameListStruct.self, url: gamelistURL, inputData: nil) { data in
            if let data = data {
                self.delegateGameList?.gameList(data: data.applist.apps.filter { $0.name != "" })
            } else {
                Alerts.noConnectServer()
            }
        }
    }
    
    func loadNew(id: Int) {
        let url = newsUrl + "\(id)"
        APIManager.loadDataGET(structData: NewsStruct.self, url: url, inputData: nil) { data in
            if let data = data {
                self.delegateGameList?.news(data: data.appnews.newsitems)
            } else {
                Alerts.noConnectServer()
            }
        }
    }
    
}
