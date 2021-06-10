//
//  ResultChoiceData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/30.
//

public struct ResultChoiceDataModel {
    private let list: [ChoiceData]
    
    public init(choiceDataModel: ChoiceDataModel) {
        self.list = Self.getMultiRandomChoiceDataList(choiceDataModel: choiceDataModel)
    }
    
    public func getList() -> [ChoiceData] {
        self.list
    }
    
    // これも本来はVeiwData(Mapper)のロジックだがviewDataが必要ないのでここに定義
    public func resultDislpeyText() -> String {
        var text = ""
        self.list.forEach { model in
            let home = model.homeSelected ? "1" : "-"
            let draw = model.drawSelected ? "0" : "-"
            let away = model.awaySelected ? "2" : "-"
            text.append("\(model.id) \(model.homeTeamName) - \(model.awayTeamName) [\(home)\(draw)\(away)]\n")
        }
        
        return text
    }
}

// static methods
extension ResultChoiceDataModel {
    private static func getMultiRandomChoiceDataList(choiceDataModel: ChoiceDataModel) -> [ChoiceData] {
        var models = choiceDataModel.getChoiceDataList()
        var lotteredTripleCount = choiceDataModel.getPickerSelectedTripleCount() - choiceDataModel.tripleCount
        var lotteredDoubleCount = choiceDataModel.getPickerSelectedDoubleCount() - choiceDataModel.doubleCount
        
        // トリプル抽選
        while lotteredTripleCount > 0 {
            let index = Int.random(in: 0 ..< models.count)
            if models[index].selectedCount() == 3 { continue }
            if models[index].selectedCount() == 2 { lotteredDoubleCount += 1}
            models[index].homeSelected = true
            models[index].awaySelected = true
            models[index].drawSelected = true
            lotteredTripleCount -= 1
        }
        
        // ダブル抽選
        while lotteredDoubleCount > 0 {
            let index = Int.random(in: 0 ..< models.count)
            if models[index].selectedCount() > 2 { continue }
            // 無選択枠のダブル昇格
            if models[index].selectedCount() == 0 {
                let numbers = [Int](0...2).shuffled().prefix(2)
                numbers.forEach { number in
                    switch number {
                    case 0:
                        models[index].homeSelected = true
                    case 1:
                        models[index].awaySelected = true
                    case 2:
                        models[index].drawSelected = true
                    default:
                        break
                    }
                }
            // シングル選択枠のダブル昇格
            } else {
                var numbers = [Int](0...2)
                if models[index].homeSelected { numbers.remove(at: 0) }
                if models[index].awaySelected { numbers.remove(at: 1) }
                if models[index].homeSelected { numbers.remove(at: 2) }
                
                let number = numbers.shuffled().prefix(1).first
                switch number {
                case 0:
                    models[index].homeSelected = true
                case 1:
                    models[index].awaySelected = true
                case 2:
                    models[index].drawSelected = true
                default:
                    break
                }
            }
            lotteredDoubleCount -= 1
        }
        
        // シングル抽選
        for i in 0..<models.count {
            if models[i].selectedCount() == 0 {
                let number = Int.random(in: 0...2)
                switch number {
                case 0:
                    models[i].homeSelected = true
                case 1:
                    models[i].awaySelected = true
                case 2:
                    models[i].drawSelected = true
                default:
                    break
                }
            }
        }
        
        return models
    }
}
