//
//  RateChartTableViewData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/18.
//

import Domain

struct RateChartTableViewData {
    private let totoList: [ChartViewData]?
    private let bookList: [ChartViewData]?
    
    init(held: Held) {
        self.totoList = RateChartTableViewData.setRates(frames: held.getFrames(), rates: held.getTotoRates())
        self.bookList = RateChartTableViewData.setRates(frames: held.getFrames(), rates: held.getBookRates())
    }
    
    // SwiftUIで画面を綺麗にするまでは単純にテキストを返す
    func getTotoRateText() -> String {
        // 暫定的に数字表示だけ
        var text = ""
        for i in 0...13 {
            if let totoChart = self.getTotoChart(index: i) {
                let record = "\(totoChart.id) \(totoChart.homeTeamName)  \(totoChart.awayTeamName)  \(totoChart.homeWinRate)   \(totoChart.drawRate)   \(totoChart.awayWinRate) \n"
                text.append(record)
            }
        }
        
        return text
    }
    
    // SwiftUIで画面を綺麗にするまでは単純にテキストを返す
    func getBookRateText() -> String {
        var text = ""
        for i in 0...13 {
            if let bookChart = self.getBookChart(index: i) {
                let record = "\(bookChart.id) \(bookChart.homeTeamName)  \(bookChart.awayTeamName)  \(bookChart.homeWinRate)   \(bookChart.drawRate)   \(bookChart.awayWinRate) \n"
                text.append(record)
            }
        }
        
        return text
    }
    
    func getTotoChart(index: Int) -> ChartViewData? {
        guard let totoList = self.totoList, totoList.count > index else {
            return nil
        }
        return totoList[index]
    }
    
    func getBookChart(index: Int) -> ChartViewData? {
        guard let bookList = self.bookList, bookList.count > index else {
            return nil
        }
        return bookList[index]
    }
    
    func existBookChart() -> Bool {
        self.bookList?.count ?? 0 > 0
    }
    
    private static func setRates(frames: [Frame]?, rates: [Rate]?) -> [ChartViewData]? {
        guard let frames = frames, let rates = rates else {
            return nil
        }
        
        var list: [ChartViewData] = []
        
        for id in 1...13 {
            let filteredFrame = frames.filter { $0.getId() == id }.first
            let filteredRate = rates.filter { $0.getId() == id }.first
            
            guard let frame = filteredFrame, let rate = filteredRate else {
                return nil
            }
            
            list.append(ChartViewData.convertToViewData(frameModel: frame , rateModel: rate))
        }
        
        return list
    }
}
