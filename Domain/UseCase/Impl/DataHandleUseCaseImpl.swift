//
//  DataHandleUseCaseImpl.swift
//  TotoRan
//  データの取得・保存を司るUseCase
//
//  Created by kosou.tei on 2021/05/14.
//

import Combine

public class DataHandleUseCaseImpl: DataHandleUseCase {
    
    private let totoDataRepository: TotoDataRepository
    
    public init(totoDataRepository: TotoDataRepository) {
        self.totoDataRepository = totoDataRepository
    }
    
    public func getHeldData() -> Future<Int?, Error> {
        self.totoDataRepository.getHeldData()
    }
    
    public func getHeldDetailData(heldNumber: Int) -> Future<Held?, Error> {
        self.totoDataRepository.getHeldDetailData(heldNumber: heldNumber)
    }
    
    public func getTotoRateData(heldNumber: Int) -> Future<([Frame], [Rate])?, Error> {
        self.totoDataRepository.getTotoRateData(heldNumber: heldNumber)
    }
    
    public func getBookRateData(heldNumber: Int) -> Future<[Rate]?, Error> {
        self.totoDataRepository.getBookRateData(heldNumber: heldNumber)
    }
    
    public func getHeld() -> Held? {
        self.totoDataRepository.getHeld()
    }
    
    public func saveHeld(_ held: Held) -> Bool {
        self.totoDataRepository.saveHeld(held)
    }
}
