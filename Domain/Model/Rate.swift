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
}
