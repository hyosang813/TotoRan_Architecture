//
//  ChoiceViewPresenter.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/20.
//

import Domain

protocol ChoiceViewPresentable {
    func didLoad()
    func checkedSelectedData(tableViewData: ChoiceTableViewData?)
}

class ChoiceViewPresenter: ChoiceViewPresentable {
    
    private weak var view: ChoiceViewable?
    private let dataHandleUseCase: DataHandleUseCase
    
    init(view: ChoiceViewable, dataHandleUseCase: DataHandleUseCase) {
        self.view = view
        self.dataHandleUseCase = dataHandleUseCase
    }
    
    func didLoad(){
        self.view?.setTableView()
        self.getTeamData()
    }
    
    func checkedSelectedData(tableViewData: ChoiceTableViewData?) {
        var list: [ChoiceData] = []
        for index in 0...12 {
            if let viewData = tableViewData?.get(index: index) {
                list.append(viewData.convertToModel())
            }
        }
        
        if list.count != tableViewData?.count() ?? 0 {
            self.view?.showAlert(reason: .dataGetFailed)
            return
        }
        
        let choiceDataModel = ChoiceDataModel(list: list)
        if choiceDataModel.possibleTransition() {
            self.view?.transitionNextVC(choiceDataModel: choiceDataModel)
        } else {
            self.view?.showAlert(reason: .combinationOver)
        }
    }
    
    private func getTeamData() {
        guard let held = self.dataHandleUseCase.getHeld() else {
            self.view?.showAlert(reason: .dataGetFailed)
            return
        }
        
        let tableViewData = ChoiceTableViewData(held: held)
        self.view?.setTeamNames(tableViewData: tableViewData)
    }
}
