//
//  ChoiceViewData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/20.
//
import UIKit

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
        ChoiceViewData(id: frameModel.id,
                      homeTeamName: frameModel.homeTeamName,
                      awayTeamName: frameModel.awayTeamName,
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
