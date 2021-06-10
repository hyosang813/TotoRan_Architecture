//
//  Rate.swift
//  TotoRan
//  支持率モデル
//
//  Created by kosou.tei on 2021/05/11.
//

public struct Rate: Codable {
    let id: Int
    let heldNumber: Int
    let homeWinRate: Double
    let awayWinRate: Double
    let drawRate: Double
    
    public init(id: Int,
                heldNumber: Int,
                homeWinRate: Double,
                awayWinRate: Double,
                drawRate: Double) {
        self.id = id
        self.heldNumber = heldNumber
        self.homeWinRate = homeWinRate
        self.awayWinRate = awayWinRate
        self.drawRate = drawRate
    }
    
    public func getId() -> Int {
        self.id
    }
    
    public func getHeldNumber() -> Int {
        self.heldNumber
    }
    
    public func getHomeWinRate() -> Double {
        self.homeWinRate
    }
    
    public func getAwayWinRate() -> Double {
        self.awayWinRate
    }
    
    public func getDrawRate() -> Double {
        self.drawRate
    }
}
