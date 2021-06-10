//
//  ChartViewData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/18.
//

import Domain

struct ChartViewData {
    let id: Int
    let homeTeamName: String
    let awayTeamName: String
    let homeWinRate: Double
    let awayWinRate: Double
    let drawRate: Double
}

extension ChartViewData {
    
    static func convertToViewData(frameModel: Frame, rateModel: Rate) -> ChartViewData {
        ChartViewData(id: frameModel.getId(),
                      homeTeamName: frameModel.getHomeTeamName(),
                      awayTeamName: frameModel.getAwayTeamName(),
                      homeWinRate: rateModel.getHomeWinRate(),
                      awayWinRate: rateModel.getAwayWinRate(),
                      drawRate: rateModel.getDrawRate())
    }
}
