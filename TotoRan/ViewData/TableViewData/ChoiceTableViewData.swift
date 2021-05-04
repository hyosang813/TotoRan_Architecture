//
//  ChoiceTableViewData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/21.
//

struct ChoiceTableViewData {
    private var list: [ChoiceViewData]?
    
    init(held: Held) {
        self.list = ChoiceTableViewData.setViewData(frames: held.frames)
    }
    
    func count() -> Int {
        if let count = self.list?.count {
            return count
        } else {
            return 0
        }
    }
    
    func cellCount() -> Int {
        return self.count() + 3 // クリアボタンと次へボタンと戻るセル分
    }
    
    func get(index: Int) -> ChoiceViewData? {
        guard let list = self.list, list.count > index else {
            return nil
        }
        return list[index]
    }
    
    mutating func setSelectedHome(id: Int, selected: Bool) {
        if let index = self.list?.firstIndex(where: { $0.id == id }) {
            self.list?[index].homeSelected = selected
        }
    }
    
    mutating func setSelectedAway(id: Int, selected: Bool) {
        if let index = self.list?.firstIndex(where: { $0.id == id }) {
            self.list?[index].awaySelected = selected
        }
    }
    
    mutating func setSelectedDraw(id: Int, selected: Bool) {
        if let index = self.list?.firstIndex(where: { $0.id == id }) {
            self.list?[index].drawSelected = selected
        }
    }
    
    mutating func clear() {
        guard let count = self.list?.count else {
            return
        }
        for index in 0...count - 1 {
            self.list?[index].homeSelected = false
            self.list?[index].awaySelected = false
            self.list?[index].drawSelected = false
        }
    }
    
    private static func setViewData(frames: [Frame]?) -> [ChoiceViewData]? {
        guard let frames = frames else {
            return nil
        }
        
        var list: [ChoiceViewData] = []
        
        for id in 1...13 {
            let filteredFrame = frames.filter { $0.id == id }.first
            guard let frame = filteredFrame else {
                return nil
            }
            
            list.append(ChoiceViewData.convertToViewData(frameModel: frame))
        }
        
        return list
    }
}
