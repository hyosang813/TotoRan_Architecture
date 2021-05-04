//
//  Held.swift
//  TotoRan
//  開催データモデル
//
//  Created by kosou.tei on 2021/05/10.
//

public struct Held: Codable {
    let heldNumber: Int
    let startYearText: String
    let startMonthText: String
    let startDayText: String
    let startTimeText: String
    let startMinuteText: String
    let endYearText: String
    let endMonthText: String
    let endDayText: String
    let endTimeText: String
    let endMinuteText: String
    var frames: [Frame]?
    var totoRates: [Rate]?
    var bookRates: [Rate]?
    var heldInfoText: String { // 原則で言えばこれはViewData(Mapper)側にあるべきだが、Presenterからテキストのみを渡すのでViewData(Mapper)の作成は冗長と判断
        var text = "対象回: 第\(heldNumber)回 toto\n"
        text.append("\(endYearText)年\(endMonthText)月\(endDayText)日 \(endTimeText)時\(endMinuteText)分 締切")
        return text
    }
}

struct TmpHled {
    let heldNumber: Int
    var startYearText: String?
    var startMonthText: String?
    var startDayText: String?
    var startTimeText: String?
    var startMinuteText: String?
    var endYearText: String?
    var endMonthText: String?
    var endDayText: String?
    var endTimeText: String?
    var endMinuteText: String?
    
    func existData() -> Bool {
        startYearText != nil &&
        startMonthText != nil &&
        startDayText != nil &&
        startTimeText != nil &&
        startMinuteText != nil &&
        endYearText != nil &&
        endMonthText != nil &&
        endDayText != nil &&
        endTimeText != nil &&
        endMinuteText != nil
    }
}
