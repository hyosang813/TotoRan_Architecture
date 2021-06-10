//
//  HeldDetailMapper.swift
//  TotoRan
//  開催詳細情報のパース処理
//
//  Created by kosou.tei on 2021/05/13.
//

import Kanna
import Domain

class HeldDetailMapper {
    
    static func parseHeldDetail(heldNumber: Int, html: String) -> Held? {
        // TODO: try?に失敗した場合のエラー処理を区別したいね
        if let doc = try? HTML(html: html, encoding: .utf8) {
            var isToto = false
            for link in doc.css("a") {
                // totoの開催有無（totoGOALとかminitotoだけの回もあるから）
                if link["href"] == "#toto" {
                    isToto = true
                    break
                }
            }
            
            if !isToto { return nil }
            
            var tmpHeld = TmpHled(heldNumber: heldNumber)
            for link in doc.css("td") {
                if link["class"] == "type5" {
                    guard let trimData = link.content?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                        return nil
                    }
                    if tmpHeld.startYearText == nil {
                        tmpHeld.startYearText = makeReqexpData(target: trimData, pattern: "(.*)(?=年)")
                        tmpHeld.startMonthText = makeReqexpData(target: trimData, pattern: "(?<=年)\\d{2}")
                        tmpHeld.startDayText = makeReqexpData(target: trimData, pattern: "(?<=月)\\d{2}")
                        tmpHeld.startTimeText = makeReqexpData(target: trimData, pattern: "\\d{2}(?=\\：)")
                        tmpHeld.startMinuteText = makeReqexpData(target: trimData, pattern: "(?<=\\：)\\d{2}")
                        
                    } else if tmpHeld.endYearText == nil {
                        tmpHeld.endYearText = makeReqexpData(target: trimData, pattern: "(.*)(?=年)")
                        tmpHeld.endMonthText = makeReqexpData(target: trimData, pattern: "(?<=年)\\d{2}")
                        tmpHeld.endDayText = makeReqexpData(target: trimData, pattern: "(?<=月)\\d{2}")
                        tmpHeld.endTimeText = makeReqexpData(target: trimData, pattern: "\\d{2}(?=\\:)")
                        tmpHeld.endMinuteText = makeReqexpData(target: trimData, pattern: "(?<=\\:)\\d{2}")
                    } else {
                        break
                    }
                }
            }
            
            guard tmpHeld.existData() else {
                return nil
            }
            
            return Held(heldNumber: tmpHeld.heldNumber,
                        startYearText: tmpHeld.startYearText!,
                        startMonthText: tmpHeld.startMonthText!,
                        startDayText: tmpHeld.startDayText!,
                        startTimeText: tmpHeld.startTimeText!,
                        startMinuteText: tmpHeld.startMinuteText!,
                        endYearText: tmpHeld.endYearText!,
                        endMonthText: tmpHeld.endMonthText!,
                        endDayText: tmpHeld.endDayText!,
                        endTimeText: tmpHeld.endTimeText!,
                        endMinuteText: tmpHeld.endMinuteText!)
        }
        
        return nil
    }
    
    private static func makeReqexpData(target: String, pattern: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let result = regex.firstMatch(in: target, options: [], range: NSRange(0..<target.count))!
        
        for i in 0..<result.numberOfRanges {
            let start = target.index(target.startIndex, offsetBy: result.range(at: i).location)
            let end = target.index(start, offsetBy: result.range(at: i).length)
            let text = String(target[start..<end])
            return text
        }
        
        return ""
    }
}
