//
//  Summuner.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 25/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class Summuner: NSObject {
    let name: String
    let level: Int
    let idSummuner: Int
    var statSummunerData: Data?
    var statMatchHistoryData: Data?
    var listeChampion: Data
    var listeSpell: Data
    
    var statAllGame = (
        totalKill: 0,
        totalAssist: 0,
        tourelleDetruite: 0,
        win: 0,
        totalMinionsKill: 0
    )
    
    struct gameInfoHistory {
        let subType: String
        let ipEarned: Int
        let championImage: UIImage
        let spell1: Int
        let spell2: Int
        let date: Int
        let level: Int
        let goldEarned: Int
        let numKill: Int
        let numDead: Int
        let numAssist: Int
        let minionsKilled: Int
        let totalDamage: Int
        let win: Bool
        
        init(subType: String, ipEarned: Int, championImage: UIImage, spell1: Int, spell2: Int, date: Int, level: Int, goldEarned: Int, numKill: Int, numDead: Int, numAssist: Int, minionsKilled: Int, totalDamage: Int, win: Bool) {
            self.subType = subType
            self.ipEarned = ipEarned
            self.championImage = championImage
            self.spell1 = spell1
            self.spell2 = spell2
            self.date = date
            self.level = level
            self.goldEarned = goldEarned
            self.numKill = numKill
            self.numDead = numDead
            self.numAssist = numAssist
            self.minionsKilled = minionsKilled
            self.totalDamage = totalDamage
            self.win = win
        }
    }
    
    struct inGameInfoPersonnage {
        let id: Int
        let name: String
        let nameChampion: String
        let image: UIImage
        let imageSpell1: UIImage
        let imageSpell2: UIImage
    }
    
    struct inGameStat {
        let kill: Int
        let death: Int
        let assist: Int
        let damageToChampion: Int
        let damageTaken: Int
        let goldEarned: Int
        let level: Int
        let minionsKilled: Int
    }
    
    struct inGameInfo {
        let gameMode: String
        let dureePartie: Int
        let championBanned: [UIImage]
        let summoners: [inGameInfoPersonnage]
        let stat: [inGameStat]
    }
    
    init(name: String, level: Int, idSummuner: Int) {
        self.name = name
        self.level = level
        self.idSummuner = idSummuner
        self.listeChampion = HttpRequestLeague().getDataFromServeur(url: ApiLeague(region: "euw").getStaticDataFromChampionWith())
        self.listeSpell = HttpRequestLeague().getDataFromServeur(url: ApiLeague(region: "euw").getStaticDataFromSpell())
        self.statMatchHistoryData = HttpRequestLeague().getDataFromServeur(url: ApiLeague(region: "euw").listGameApi(summunerId: self.idSummuner))
    }
    
    func statParGame (typeDePartie: String) {
        let dictionaryData = Utils().deserealization(data: statSummunerData!)
        
        if let stats: [AnyObject] = dictionaryData["playerStatSummaries"] as? [AnyObject] {
            let stat = stats.filter{$0["playerStatSummaryType"] as? String == typeDePartie}
            self.statAllGame.win = stat[0]["wins"] as? Int ?? 0
            let statPartie = stat[0]["aggregatedStats"]! as? NSDictionary
            self.statAllGame.totalKill = statPartie!["totalChampionKills"] as? Int ?? 0
            self.statAllGame.totalAssist = statPartie!["totalAssists"] as? Int ?? 0
            self.statAllGame.tourelleDetruite = statPartie!["totalTurretsKilled"] as? Int ?? 0
            self.statAllGame.totalMinionsKill = statPartie!["totalMinionKills"] as? Int ?? 0
        }
    }
    
    func getListePartie () -> [String] {
        let dictionaryData = Utils().deserealization(data: statSummunerData!)
        
        if let stats: [AnyObject] = dictionaryData["playerStatSummaries"] as? [AnyObject] {
            return stats.map{$0["playerStatSummaryType"] as! String}
                        .sorted{$0 < $1}
        } else {
            return [String]()
        }
    }
    
    func getMatchHistory () -> [gameInfoHistory]{
        let dictionaryData = Utils().deserealization(data: statMatchHistoryData!)
        
        if let games: [AnyObject] = dictionaryData["games"] as? [AnyObject] {
            return games.map{
                let stat = $0["stats"] as AnyObject
                return gameInfoHistory(
                    subType: $0["subType"] as? String ?? "",
                    ipEarned: $0["ipEarned"] as? Int ?? 0,
                    championImage: getChampionImageWith(idChampion: ($0["championId"] as? Int)!) as UIImage,
                    spell1: $0["spell1"] as? Int ?? 0,
                    spell2: $0["spell2"] as? Int ?? 0,
                    date: $0["createDate"] as? Int ?? 0,
                    level: stat["level"] as? Int ?? 0,
                    goldEarned: stat["goldEarned"] as? Int ?? 0,
                    numKill: stat["championsKilled"] as? Int ?? 0,
                    numDead: stat["numDeaths"] as? Int ?? 0,
                    numAssist: stat["assists"] as? Int ?? 0,
                    minionsKilled: stat["minionsKilled"] as? Int ?? 0,
                    totalDamage: stat["totalDamageDealt"] as? Int ?? 0,
                    win: stat["win"] as? Bool ?? false
                )
            }
        }
        else {
            return []
        }
    }
    
    func getChampionName(idChampion: Int) -> String {
        let dictionaryData = Utils().deserealization(data: self.listeChampion)
        if let champions: [String: AnyObject] = dictionaryData["data"] as? [String: AnyObject] {
            let champion = champions.first(where: {
                let champ = $0 as (String, AnyObject)
                return champ.1["id"] as! Int == idChampion
            })
            let championName = champion!.value["key"] as! String
            return championName
        }
        return ""
    }
    
    func getChampionImageWith (idChampion: Int) -> UIImage {
        return UIImage(data: HttpRequestLeague().getDataFromServeur(url: "http://ddragon.leagueoflegends.com/cdn/7.8.1/img/champion/\(getChampionName(idChampion: idChampion)).png"))!
    }
    
    func getInGameInfo (idSummoner: Int) -> [inGameInfo] {
        let data = HttpRequestLeague().getDataFromServeur(url: ApiLeague(region: "euw").getInGameInfo(summonerId: idSummoner))
        let dictionaryData = Utils().deserealization(data: data)
        if let gameInfo: [String: AnyObject] = dictionaryData as? [String: AnyObject]{
            if (gameInfo.first?.key == "status")
            {
                return []
            }
            let bannedChampion = gameInfo["bannedChampions"] as! [AnyObject]
            let participant = gameInfo["participants"] as! [AnyObject]
            return [inGameInfo(gameMode: gameInfo["gameMode"] as! String,
                               dureePartie: gameInfo["gameLength"] as! Int,
                               championBanned: bannedChampion.map{
                                return getChampionImageWith(idChampion: $0["championId"] as! Int)
                                },
                               summoners: participant.map{
                                return inGameInfoPersonnage(id: $0["summonerId"] as! Int,
                                                            name: $0["summonerName"] as! String,
                                                            nameChampion: getChampionName(idChampion: ($0["championId"]) as! Int),
                                                            image: getChampionImageWith(idChampion: ($0["championId"]) as! Int),
                                                            imageSpell1: getSpellImageWith(idSpell: $0["spell1Id"] as! Int),
                                                            imageSpell2: getSpellImageWith(idSpell: $0["spell2Id"] as! Int)
                                )
                                },
                               stat: getStatMatchWith(idMatch: gameInfo["gameId"] as! Int)
                )]
        } else {
            return []
        }
    }
    
    func getSpellNameWith (idSpell: Int) -> String {
        let dictionaryData = Utils().deserealization(data: self.listeSpell)
        if let spells: [String: AnyObject] = dictionaryData["data"] as? [String: AnyObject] {
            let spell = spells.first(where: {
                let spell = $0 as (String, AnyObject)
                return spell.1["id"] as! Int == idSpell
            })
            let spellName = spell!.value["key"] as! String
            return spellName
        }
        return ""
    }
    
    func getSpellImageWith (idSpell: Int) -> UIImage {
        return UIImage(data: HttpRequestLeague().getDataFromServeur(url: "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/spell/\(getSpellNameWith(idSpell: idSpell)).png"))!
    }
    
    func getStatMatchWith (idMatch: Int) -> [inGameStat]{
        let data = HttpRequestLeague().getDataFromServeur(url: ApiLeague(region: "euw").statGame(matchId: idMatch))
        let dictionnaryData = Utils().deserealization(data: data)
        if let participants: [AnyObject] = dictionnaryData["participants"] as? [AnyObject] {
            return participants.map{
                let stats = $0["stats"] as (AnyObject)
                return inGameStat(
                    kill: stats["kills"] as! Int,
                    death: stats["deaths"] as! Int,
                    assist: stats["assists"] as! Int,
                    damageToChampion: stats["totalDamageDealtToChampions"] as! Int,
                    damageTaken: stats["totalDamageTaken"] as! Int,
                    goldEarned: stats["goldEarned"] as! Int,
                    level: stats["champLevel"] as! Int,
                    minionsKilled: stats["minionsKilled"] as! Int
                )
            }
        }
        return []
    }
}












