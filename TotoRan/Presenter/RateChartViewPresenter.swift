//
//  RateChartViewPresenter.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/18.
//

import Domain

protocol RateChartViewPresentable {
    func didLoad()
    func onTapSegmentedControll(index: Int)
}

class RateChartViewPresenter: RateChartViewPresentable {
    
    private weak var view: RateChartViewable?
    private let dataHandleUseCase: DataHandleUseCase
    
    init(view: RateChartViewable, dataHandleUseCase: DataHandleUseCase) {
        self.view = view
        self.dataHandleUseCase = dataHandleUseCase
    }
    
    func didLoad(){
        self.view?.setUp()
        getHeld(index: 0)
    }
    
    func onTapSegmentedControll(index: Int) {
        getHeld(index: index)
    }
    
    private func getHeld(index: Int) {
        guard let held = dataHandleUseCase.getHeld() else {
            self.view?.showAlert(reason: .dataGetFailed)
            return
        }
        
        let tableViewData = RateChartTableViewData(held: held)
        
        if index == 0 {
            self.view?.load(text: tableViewData.getTotoRateText())
        } else {
            let text = tableViewData.getBookRateText()
            if text == "" {
                self.view?.showAlert(reason: .notBookRate)
            } else {
                self.view?.load(text: text)
            }
        }
    }
}
