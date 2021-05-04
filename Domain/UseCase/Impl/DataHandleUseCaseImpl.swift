//
//  DataHandleUseCaseImpl.swift
//  TotoRan
//  データの取得・保存を司るUseCase
//
//  Created by kosou.tei on 2021/05/14.
//

import RxSwift

class DataHandleUseCaseImpl: DataHandleUseCase {
    
    private let totoDataRepository: TotoDataRepository
    
    init(totoDataRepository: TotoDataRepository) {
        self.totoDataRepository = totoDataRepository
    }
    
    func getHeldData() -> Single<Int?> {
        self.totoDataRepository.getHeldData()
    }
    
    func getHeldDetailData(heldNumber: Int) -> Single<Held?> {
        self.totoDataRepository.getHeldDetailData(heldNumber: heldNumber)
    }
    
    func getTotoRateData(heldNumber: Int) -> Single<([Frame], [Rate])?> {
        self.totoDataRepository.getTotoRateData(heldNumber: heldNumber)
    }
    
    func getBookRateData(heldNumber: Int) -> Single<[Rate]?> {
        self.totoDataRepository.getBookRateData(heldNumber: heldNumber)
    }
    
    func getHeld() -> Held? {
        self.totoDataRepository.getHeld()
    }
    
    func saveHeld(_ held: Held) -> Bool {
        self.totoDataRepository.saveHeld(held)
    }
}
