//
//  JudgeResultViewPresenter.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/06/01.
//

import Domain

protocol JudgeResultViewPresentable {
    func didLoad()
}

class JudgeResultViewPresenter: JudgeResultViewPresentable {
    
    private weak var view: JudgeResultViewable?
    private let dataHandleUseCase: DataHandleUseCase
    private let choiceDataList: [ChoiceData]
    
    init(view: JudgeResultViewable, dataHandleUseCase: DataHandleUseCase, choiceDataList: [ChoiceData]) {
        self.view = view
        self.dataHandleUseCase = dataHandleUseCase
        self.choiceDataList = choiceDataList
    }
    
    func didLoad(){
        self.view?.setUp()
        self.getJudgeData()
    }
    
    private func getJudgeData() {
        if let held = dataHandleUseCase.getHeld() {
            let text = Judge(choiceDataList: self.choiceDataList, held: held).getJudgeData()
            self.view?.dsiplayJedgeData(text: text)
        }
    }
}
