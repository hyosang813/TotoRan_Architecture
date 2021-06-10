//
//  ChoiceViewData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/20.
//

import UIKit
import Domain

struct ChoiceViewData {
    let id: Int
    let homeTeamName: String
    let awayTeamName: String
    var homeSelected: Bool
    var awaySelected: Bool
    var drawSelected: Bool
}

extension ChoiceViewData {
    
    static func convertToViewData(frameModel: Frame) -> ChoiceViewData {
        ChoiceViewData(id: frameModel.getId(),
                      homeTeamName: frameModel.getHomeTeamName(),
                      awayTeamName: frameModel.getAwayTeamName(),
                      homeSelected: false,
                      awaySelected: false,
                      drawSelected: false)
    }
    
    func convertToModel() -> ChoiceData {
        ChoiceData(id: self.id,
                   homeTeamName: self.homeTeamName,
                   awayTeamName: self.awayTeamName,
                   homeSelected: self.homeSelected,
                   awaySelected: self.awaySelected,
                   drawSelected: self.drawSelected)
    }
}
