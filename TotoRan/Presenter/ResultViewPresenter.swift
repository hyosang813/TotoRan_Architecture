//
//  ResultViewPresenter.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/29.
//

protocol ResultViewPresentable {
    func didLoad()
    func onTapJudgeButton()
}

class ResultViewPresenter: ResultViewPresentable {
    
    private weak var view: ResultViewable?
    private let resultChoiceDataModel: ResultChoiceDataModel
    
    init(view: ResultViewable, choiceDataModel: ChoiceDataModel) {
        self.view = view
        self.resultChoiceDataModel = ResultChoiceDataModel(choiceDataModel: choiceDataModel)
    }
    
    func didLoad(){
        self.view?.setUp()
        self.view?.resultDisplay(text: self.resultChoiceDataModel.resultDislpeyText())
    }
    
    func onTapJudgeButton() {
        self.view?.transitionJudgeResultVC(choiceDataList: self.resultChoiceDataModel.getList())
    }
}
