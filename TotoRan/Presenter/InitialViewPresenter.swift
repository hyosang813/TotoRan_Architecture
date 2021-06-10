//
//  InitialViewPresenter.swift
//  TotoRan
//  初期画面のPresenter
//
//  Created by kosou.tei on 2021/05/14.
//

import RxSwift
import Domain

protocol InitialViewPresentable {
    func didLoad()
    func refreshData()
    func transitionChoiceVC()
    func transitionRateChartVC()
}

class InitialViewPresenter: InitialViewPresentable {
    
    private weak var view: InitialViewable?
    private let dataHandleUseCase: DataHandleUseCase
    private let disposeBag = DisposeBag()
    
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
        dataHandleUseCase.getHeldData()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] heldNumber in
                if let heldNumber = heldNumber {
                    self?.getHeldDetailData(heldNumber: heldNumber)
                } else {
                    self?.showAlert(reason: .noHeld)
                }
            }, onFailure: { [weak self] error in
                self?.showAlert(reason: .dataGetFailed)
            })
            .disposed(by: disposeBag)
    }
    
    private func getHeldDetailData(heldNumber: Int) {
        dataHandleUseCase.getHeldDetailData(heldNumber: heldNumber)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] held in
                if let held = held {
                    self?.getRateData(held: held)
                } else {
                    self?.showAlert(reason: .dataGetFailed)
                }
            }, onFailure: { [weak self] error in
                self?.showAlert(reason: .dataGetFailed)
            })
            .disposed(by: disposeBag)
    }
    
    private func getRateData(held: Held) {
        Single.zip(dataHandleUseCase.getTotoRateData(heldNumber: held.getHeldNumber()),
                   dataHandleUseCase.getBookRateData(heldNumber: held.getHeldNumber()))
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] frameAndTotRates, bookRates in
                var held = held
                if let frameAndTotRates = frameAndTotRates {
                    held.setFrames(frameAndTotRates.0)
                    held.setTotoRates(frameAndTotRates.1)
                } else {
                    self?.showAlert(reason: .dataGetFailed)
                    return
                }
                
                if let bookRates = bookRates {
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
                
            }, onFailure: { [weak self] error in
                self?.showAlert(reason: .dataGetFailed)
            })
            .disposed(by: disposeBag)
    }
}
