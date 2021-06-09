//
//  HeldMapper.swift
//  TotoRan
//  開催回情報のパース処理
//
//  Created by kosou.tei on 2021/05/13.
//

import Kanna

class HeldMapper {
    
    static func parseHeld(html: String) -> Int? {
        // TODO: try?に失敗した場合のエラー処理を区別したいね
        if let doc = try? HTML(html: html, encoding: .utf8) {
            for link in doc.css("a") {
                let baseString = "/toto/schedule/"
                if
                    let target = link["href"],
                    target.hasPrefix(baseString),
                    target.hasSuffix("/"),
                    target.count > baseString.count + 3 {
                    let partialString = target[target.index(target.startIndex, offsetBy: baseString.count)...target.index(target.startIndex, offsetBy: baseString.count + 3)]
                    if link.content == "販売中" {
                        return Int(partialString)
                    }
                }
            }
        }
        // 販売中のくじが見つからない場合はnil
        return nil
    }
}
