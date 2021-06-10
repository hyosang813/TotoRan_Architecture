//
//  DataHandleUseCaseImpl.swift
//  TotoRan
//  データの取得・保存を司るUseCase
//
//  Created by kosou.tei on 2021/05/14.
//

import RxSwift

public class DataHandleUseCaseImpl: DataHandleUseCase {
    
    private let totoDataRepository: TotoDataRepository
    
    public init(totoDataRepository: TotoDataRepository) {
        self.totoDataRepository = totoDataRepository
    }
    
    public func getHeldData() -> Single<Int?> {
        self.totoDataRepository.getHeldData()
    }
    
    public func getHeldDetailData(heldNumber: Int) -> Single<Held?> {
        self.totoDataRepository.getHeldDetailData(heldNumber: heldNumber)
    }
    
    public func getTotoRateData(heldNumber: Int) -> Single<([Frame], [Rate])?> {
        self.totoDataRepository.getTotoRateData(heldNumber: heldNumber)
    }
    
    public func getBookRateData(heldNumber: Int) -> Single<[Rate]?> {
        self.totoDataRepository.getBookRateData(heldNumber: heldNumber)
    }
    
    public func getHeld() -> Held? {
        self.totoDataRepository.getHeld()
    }
    
    public func saveHeld(_ held: Held) -> Bool {
        self.totoDataRepository.saveHeld(held)
    }
}
