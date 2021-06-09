//
//  ChartViewData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/18.
//

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
        ChartViewData(id: frameModel.id,
                      homeTeamName: frameModel.homeTeamName,
                      awayTeamName: frameModel.awayTeamName,
                      homeWinRate: rateModel.homeWinRate,
                      awayWinRate: rateModel.awayWinRate,
                      drawRate: rateModel.drawRate)
    }
}
