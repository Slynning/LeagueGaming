//
//  ApiLeague.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 24/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class ApiLeague: NSObject {
    
    let urlApiLeague = "https://euw1.api.riotgames.com/lol"
    let region: String
    
    init(region: String) {
        self.region = region
    }
    
    func summunerApi(summunerName: String) -> String {
        return "\(urlApiLeague)/summoner/v3/summoners/by-name/" + summunerName
    }
    
    func listGameApi(summunerId: Int) -> String{
        return "https://euw.api.riotgames.com/api/lol/EUW/v1.3/game/by-summoner/\(summunerId)/recent"
    }
    
    func statSummonerWith(summonerId: Int) -> String{
        return "https://euw.api.riotgames.com/api/lol/EUW/v1.3/stats/by-summoner/\(summonerId)/summary"
    }
    
    func statGame(matchId: Int) -> String {
        return urlApiLeague + self.region + "/v2.2/match/\(matchId)"
    }
    
    func getStaticDataFromChampionWith() -> String {
        return "\(urlApiLeague)/static-data/v3/champions"
    }
    
    func getStaticDataFromSpell() -> String {
        return "\(urlApiLeague)/static-data/v3/summoner-spells"
    }
    
    func getInGameInfo(summonerId: Int) -> String {
        return "\(urlApiLeague)/spectator/v3/active-games/by-summoner/\(summonerId)"
    }
}
