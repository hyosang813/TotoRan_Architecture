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
    var frames: [Frame]? = nil
    var totoRates: [Rate]? = nil
    var bookRates: [Rate]? = nil
    
    public init(heldNumber: Int,
                startYearText: String,
                startMonthText: String,
                startDayText: String,
                startTimeText: String,
                startMinuteText: String,
                endYearText: String,
                endMonthText: String,
                endDayText: String,
                endTimeText: String,
                endMinuteText: String) {
        self.heldNumber = heldNumber
        self.startYearText = startYearText
        self.startMonthText = startMonthText
        self.startDayText = startDayText
        self.startTimeText = startTimeText
        self.startMinuteText = startMinuteText
        self.endYearText = endYearText
        self.endMonthText = endMonthText
        self.endDayText = endDayText
        self.endTimeText = endTimeText
        self.endMinuteText = endMinuteText
    }
    
    public func getHeldNumber() -> Int {
        self.heldNumber
    }
    
    public func getFrames() -> [Frame]? {
        self.frames
    }
    
    public func getTotoRates() -> [Rate]? {
        self.totoRates
    }
    
    public func getBookRates() -> [Rate]? {
        self.bookRates
    }
    
    public mutating func setFrames(_ frames: [Frame]) {
        self.frames = frames
    }
    
    public mutating func setTotoRates(_ rates: [Rate]) {
        self.totoRates = rates
    }
    
    public mutating func setBookRates(_ rates: [Rate]) {
        self.bookRates = rates
    }
    
    // 原則で言えばこれはViewData(Mapper)側にあるべきだが、Presenterからテキストのみを渡すのでViewData(Mapper)の作成は冗長と判断
    public func getHeldInfoText() -> String {
        var text = "対象回: 第\(heldNumber)回 toto\n"
        text.append("\(endYearText)年\(endMonthText)月\(endDayText)日 \(endTimeText)時\(endMinuteText)分 締切")
        return text
    }
}

public struct TmpHled {
    public let heldNumber: Int
    public var startYearText: String?
    public var startMonthText: String?
    public var startDayText: String?
    public var startTimeText: String?
    public var startMinuteText: String?
    public var endYearText: String?
    public var endMonthText: String?
    public var endDayText: String?
    public var endTimeText: String?
    public var endMinuteText: String?
    
    public init(heldNumber: Int) {
        self.heldNumber = heldNumber
    }
    
    public func existData() -> Bool {
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
