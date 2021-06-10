//
//  Frame.swift
//  TotoRan
//  枠モデル
//
//  Created by kosou.tei on 2021/05/10.
//

public struct Frame: Codable {
    let id: Int
    let heldNumber: Int
    let homeTeamName: String
    let awayTeamName: String
    
    public init(id: Int,
                heldNumber: Int,
                homeTeamName: String,
                awayTeamName: String) {
        self.id = id
        self.heldNumber = heldNumber
        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
    }
    
    public func getId() -> Int {
        self.id
    }
    
    public func getHeldNumber() -> Int {
        self.heldNumber
    }
    
    public func getHomeTeamName() -> String {
        self.homeTeamName
    }
    
    public func getAwayTeamName() -> String {
        self.awayTeamName
    }
}
