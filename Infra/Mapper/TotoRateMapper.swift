//
//  TotoRateMapper.swift
//  TotoRan
//  Toto支持率情報のパース処理
//
//  Created by kosou.tei on 2021/05/13.
//

import Kanna

class TotoRateMapper {
    
    static func parseTotoRate(html: String, heldNumber: Int) -> ([Frame], [Rate])? {
        // TODO: try?に失敗した場合のエラー処理を区別したいね
        if let doc = try? HTML(html: html, encoding: .utf8) {
            
            var teamNames: [String] = []
            for link in doc.css("td") {
                if link["rowspan"] == "2" {
                    guard let trimData = link.content?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                        return nil
                    }
                    if let teamName = filterTeamName(data: trimData) {
                        teamNames.append(teamName)
                    }
                }
            }
            var arrangeRates: [Double] = []
            for link in doc.css("td") {
                if link["class"] == "pernum" {
                    guard let trimData = link.content?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                        return nil
                    }
                    if let arrangeRate = arrangeRateData(target: trimData) {
                        arrangeRates.append(arrangeRate)
                    }
                }
            }
            
            // 正常にデータ取得できてるかどうか
            if teamNames.count != 26 || arrangeRates.count != 39 {
                return nil
            }
            
            var frames: [Frame] = []
            var rates: [Rate] = []
            for i in 1...13 {
                let tmpTeamNames = teamNames[0...1]
                let tmpArrangeRates = arrangeRates[0...2]
                frames.append(Frame(id: i,
                                    heldNumber: heldNumber,
                                    homeTeamName: tmpTeamNames[0],
                                    awayTeamName: tmpTeamNames[1]))
                rates.append(Rate(id: i,
                                    heldNumber: heldNumber,
                                    homeWinRate: tmpArrangeRates[0],
                                    awayWinRate: tmpArrangeRates[2],
                                    drawRate: tmpArrangeRates[1]))
                teamNames.removeFirst(2)
                arrangeRates.removeFirst(3)
            }
            
            return (frames, rates)
        }
        
        return nil
    }
    
    private static func filterTeamName(data: String) -> String? {
        if data == "データ" || Int(String(data.first ?? "0")) != nil {
            return nil
        } else {
            return data
        }
    }
    
    private static func arrangeRateData(target: String) -> Double? {
        let pattern = "(?<=\\（).+?(?=\\）)"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let result = regex.firstMatch(in: target, options: [], range: NSRange(0..<target.count))!
        
        for i in 0..<result.numberOfRanges {
            let start = target.index(target.startIndex, offsetBy: result.range(at: i).location)
            let end = target.index(start, offsetBy: result.range(at: i).length - 1)
            return Double(target[start..<end])
        }
        
        return nil
    }
}
