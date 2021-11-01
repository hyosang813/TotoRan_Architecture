//
//  InitialViewPresenter.swift
//  TotoRan
//  初期画面のPresenter
//
//  Created by kosou.tei on 2021/05/14.
//

import Combine
import Domain
import Foundation

protocol InitialViewPresentable {
    func didLoad()
    func refreshData()
    func transitionChoiceVC()
    func transitionRateChartVC()
}

class InitialViewPresenter: InitialViewPresentable {
    
    private weak var view: InitialViewable?
    private let dataHandleUseCase: DataHandleUseCase
    
    init(view: InitialViewable, dataHandleUseCase: DataHandleUseCase) {
        self.view = view
        self.dataHandleUseCase = dataHandleUseCase
    }
    
    func didLoad() {
        self.view?.showLoadingAnimation()
        getHeldData()
    }
    
    func refreshData() {
        self.view?.showLoadingAnimation()
        getHeldData()
    }
    
    func transitionChoiceVC() {
        self.view?.transitionChoiceVC()
    }
    
    func transitionRateChartVC() {
        self.view?.transitionRateChartVC()
    }
    
    private func showAlert(reason: InitialViewAlertReason) {
        self.view?.showAlert(reason: reason)
        self.view?.setUpOnFailed()
        self.view?.hideLoadingAnimation()
    }
    
    private func getHeldData() {
        self.dataHandleUseCase.getHeldData()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.showAlert(reason: .dataGetFailed)
                }
            }, receiveValue: { [weak self] response in
                if let heldNumber = response {
                    self?.getHeldDetailData(heldNumber: heldNumber)
                } else {
                    self?.showAlert(reason: .noHeld)
                }
            })
    }
    
    private func getHeldDetailData(heldNumber: Int) {
        self.dataHandleUseCase.getHeldDetailData(heldNumber: heldNumber)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.showAlert(reason: .dataGetFailed)
                }
            }, receiveValue: { [weak self] response in
                if let held = response {
                    self?.getRateData(held: held)
                } else {
                    self?.showAlert(reason: .dataGetFailed)
                }
            })
    }
    
    private func getRateData(held: Held) {
        Publishers.Zip(self.dataHandleUseCase.getTotoRateData(heldNumber: held.getHeldNumber()),
                       self.dataHandleUseCase.getBookRateData(heldNumber: held.getHeldNumber()))
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.showAlert(reason: .dataGetFailed)
                }
            }, receiveValue: { [weak self] response in
                var held = held
                if let frameAndTotRates = response.0 {
                    held.setFrames(frameAndTotRates.0)
                    held.setTotoRates(frameAndTotRates.1)
                } else {
                    self?.showAlert(reason: .dataGetFailed)
                    return
                }

                if let bookRates = response.1 {
                    held.setBookRates(bookRates)
                } else {
                    // まだboodsがないだけのパターンと失敗パターンがあるけど失敗パターンは一旦考慮外
                }
                // データをローカル格納
                if !(self?.dataHandleUseCase.saveHeld(held) ?? false) {
                    self?.showAlert(reason: .dataSaveFailed)
                    return
                }

                self?.view?.setHeldInfo(text: held.getHeldInfoText())
                self?.view?.setUpOnSuccess()
                self?.view?.hideLoadingAnimation()
            })
    }
}
