//
//  BookRateMapper.swift
//  TotoRan
//  Book支持率情報のパース処理
//
//  Created by kosou.tei on 2021/05/13.
//

import Kanna
import Domain

class BookRateMapper {
    
    static func parseBookRate(html: String, heldNumber: Int) -> [Rate]? {
        // TODO: try?に失敗した場合のエラー処理を区別したいね
        if let doc = try? HTML(html: html, encoding: .utf8) {
            
            var arrangeRates: [Double] = []
            for link in doc.css("td") {
                if link["class"] == "ave" {
                    guard let trimData = link.content?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                        return nil
                    }
                    
                    if let doubleData = Double(trimData.replacingOccurrences(of: "%", with: "")) {
                        arrangeRates.append(doubleData)
                    }
                }
            }
            
            // 正常にデータ取得できてるかどうか(boodsデータがまだない場合も含む)
            if arrangeRates.count != 81 {
                return nil
            }
            
            var rates: [Rate] = []
            for i in 1...13 {
                let tmpArrangeRates = arrangeRates[0...5]
                rates.append(Rate(id: i,
                                  heldNumber: heldNumber,
                                  homeWinRate: tmpArrangeRates[3],
                                  awayWinRate: tmpArrangeRates[5],
                                  drawRate: tmpArrangeRates[4]))
                arrangeRates.removeFirst(6)
            }
            
            return rates
        }
        
        return nil
    }
}
