//
//  ApiLeague.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 24/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class ApiLeague: NSObject {
    
    let urlApiLeague = "https://euw.api.pvp.net/api/lol/"
    let region: String
    
    init(region: String) {
        self.region = region
    }
    
    func listGameApi(summunerId: Int) -> String{
        return urlApiLeague + self.region + "/v1.3/game/by-summoner/\(summunerId)/recent"
    }
    
    func statSummonerWith(summonerId: Int) -> String{
        return urlApiLeague + self.region + "/v1.3/stats/by-summoner/\(summonerId)/summary"
    }
    
    func statGame(matchId: Int) -> String {
        return urlApiLeague + self.region + "/v2.2/match/\(matchId)"
    }
    
    func summunerApi(summunerName: String) -> String {
        return urlApiLeague + self.region + "/v1.4/summoner/by-name/" + summunerName
    }
    
    func getStaticDataFromChampionWith() -> String {
        return "https://global.api.pvp.net/api/lol/static-data/\(self.region)/v1.2/champion/"
    }
    
    func getStaticDataFromSpell() -> String {
        return "https://global.api.pvp.net/api/lol/static-data/\(self.region)/v1.2/summoner-spell/"
    }
    
    func getInGameInfo(summonerId: Int) -> String {
        return "https://\(self.region).api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/EUW1/\(summonerId)"
    }
}
