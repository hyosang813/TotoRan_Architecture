//
//  Judge.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/06/01.
//

import Foundation

public struct Judge {
    let choiceDataList: [ChoiceData]
    let held: Held
    
    public init(choiceDataList: [ChoiceData], held: Held) {
        self.choiceDataList = choiceDataList
        self.held = held
    }
    
    public func getJudgeData() -> String {
        
        let convertedTuple = self.convertBoolToNumber()
        let allPetternArray = self.makeAllPetternArray(convertArray: convertedTuple.convertArray, combiCount: convertedTuple.combiCount)
        
        var text = ""
        
        allPetternArray.forEach { array in
            text.append(self.convertString(array: array))
            if held.totoRates != nil { text.append(self.judgeToto(array: array)) }
            if held.bookRates != nil { text.append(self.judgeBook(array: array)) }
            text.append("\n")
        }
        
        return text
    }
    
    // 選択値のBoolを数字(1,2,0)に変換
    private func convertBoolToNumber() -> (convertArray: [[Int]], combiCount: Int) {
        var convertArray: [[Int]] = []
        var combiCount = 1
        choiceDataList.forEach { choiceData in
            var array: [Int] = []
            if choiceData.homeSelected { array.append(1) }
            if choiceData.awaySelected { array.append(2) }
            if choiceData.drawSelected { array.append(0) }
            convertArray.append(array)
            combiCount *= array.count
        }
        
        return (convertArray, combiCount)
    }
    
    // 数字(1,2,0)の全パターン組み合わせを生成
    private func makeAllPetternArray(convertArray: [[Int]], combiCount: Int) -> [[Int]] {
        var allPetternArray: [[Int]] = []
        var p = 0, s = 0 // p:商, s:余り
        
        for i in 0..<combiCount {
            var hanteiChildArray: [Int] = []
            p = i
            for j in 0..<convertArray.count {
                s = p % convertArray[j].count
                p = (p - s) / convertArray[j].count
                hanteiChildArray.append(convertArray[j][s])
            }
            allPetternArray.append(hanteiChildArray)
        }
        return allPetternArray
    }
    
    // 数字のArrayを文字列に変換(5桁区切りのスペース込み)
    private func convertString(array: [Int]) -> String {
        var text = array.map {String($0)}.joined()
        text.insert(" ", at: text.index(text.startIndex, offsetBy: 5))
        text.insert(" ", at: text.index(text.startIndex, offsetBy: 11))
        return text
    }
    
    // totoの判定情報
    private func judgeToto(array: [Int]) -> String {
        self.judge(array: array, rates: self.held.totoRates!).uppercased()
    }
    
    // bookの判定情報
    private func judgeBook(array: [Int]) -> String {
        self.judge(array: array, rates: self.held.bookRates!)
    }
    
    // 判定ロジック
    private func judge(array: [Int], rates: [Rate]) -> String {
        var text = " "
        var average: Double = 1.0
        
        for i in 0..<array.count {
            let selectData = array[i]
            
            switch selectData {
            case 1:
                average = average * (rates[i].homeWinRate / 100)
            case 2:
                average = average * (rates[i].awayWinRate / 100)
            case 0:
                average = average * (rates[i].drawRate / 100)
            default:
                break // 有り得ないはず
            }
        }
        
        average = average / 0.000000627 // 基準値
        
        switch average {
        case (let average) where average >= 50.0:
            text.append("s")
        case (let average) where average >= 30.0:
            text.append("a")
        case (let average) where average >= 10.0:
            text.append("b")
        case (let average) where average >= 5.0:
            text.append("c")
        case (let average) where average >= 1.0:
            text.append("d")
        case (let average) where average >= 0.01:
            text.append("e")
        default:
            text.append("f")
        }
        
        if average >= 1.0 {
            text.append("[\(Int(average).description)]")
        } else {
            text.append("[\(self.getOneOrLessString(avarage: average))]")
        }
        
        return text
    }
    
    private func getOneOrLessString(avarage: Double) -> String {
        let avarageText = avarage.description
        var text = ""
        
        for i in 0..<avarageText.count {
            text.append(Array(avarageText)[i])
            if !["0", "."].contains(Array(avarageText)[i]) {
                break
            }
        }
        
        return text.count > 6 ? "0" : text
    }
}
