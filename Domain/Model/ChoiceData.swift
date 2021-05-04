//
//  ChoiceData.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/23.
//

struct ChoiceData {
    let id: Int
    let homeTeamName: String
    let awayTeamName: String
    var homeSelected: Bool
    var awaySelected: Bool
    var drawSelected: Bool
    
    func selectedCount() -> Int {
        [homeSelected, awaySelected, drawSelected].filter { $0 == true }.count
    }
}

struct ChoiceDataModel {
    private let list: [ChoiceData]
    private var pickerSelectedDoubleCount = 0
    private var pickerSelectedTripleCount = 0
    
    init(list: [ChoiceData]) {
        self.list = list
    }
    
    var doubleCount: Int {
        self.list.filter { $0.selectedCount() == 2 }.count
    }
    
    var tripleCount: Int {
        self.list.filter { $0.selectedCount() == 3 }.count
    }
    
    var doublePickerList: [Int] {
        [Int](doubleCount...8)
    }
    
    var triplePickerList: [Int] {
        [Int](tripleCount...5)
    }
    
    func possibleTransition() -> Bool {
        self.possibleTransition(doubleCount: self.doubleCount, tripleCount: self.tripleCount)
    }
    
    func possibleTransitionForPickerSelected(doubleCount: Int, tripleCount: Int) -> Bool {
        self.possibleTransition(doubleCount: doubleCount, tripleCount: tripleCount)
    }
    
    func getChoiceDataList() -> [ChoiceData] {
        self.list
    }
    
    func getPickerSelectedDoubleCount() -> Int {
        self.pickerSelectedDoubleCount
    }
    
    func getPickerSelectedTripleCount() -> Int {
        self.pickerSelectedTripleCount
    }

    mutating func setPickerSelectedCount(doubleCount: Int, tripleCount: Int) {
        self.pickerSelectedDoubleCount = doubleCount
        self.pickerSelectedTripleCount = tripleCount
    }
    
    // TODO: なんかロジックがダサい。もっとスタイリッシュな方法ないかな？
    private func possibleTransition(doubleCount: Int, tripleCount: Int) -> Bool {
        // 486口が最大数
        if doubleCount > 8 { return false } //wは最高8個まで
        if tripleCount > 5 { return false } //tは最高5個まで
        if doubleCount == 0 && tripleCount > 5 { return false } //wが0の時はtは5まで
        if doubleCount == 1 && tripleCount > 5 { return false } //wが1の時はtは5まで
        if doubleCount == 2 && tripleCount > 4 { return false } //wが2の時はtは4まで
        if doubleCount == 3 && tripleCount > 3 { return false } //wが3の時はtは3まで
        if doubleCount == 4 && tripleCount > 3 { return false } //wが4の時はtは3まで
        if doubleCount == 5 && tripleCount > 2 { return false } //wが5の時はtは2まで
        if doubleCount == 6 && tripleCount > 1 { return false } //wが6の時はtは1まで
        if doubleCount == 7 && tripleCount > 1 { return false } //wが7の時はtは1まで
        if doubleCount == 8 && tripleCount > 0 { return false } //wが8の時はtは0まで
        
        return true
    }
}
