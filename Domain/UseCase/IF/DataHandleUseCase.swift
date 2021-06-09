//
//  DataHandleUseCase.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/14.
//

import RxSwift

public protocol DataHandleUseCase {
    func getHeldData() -> Single<Int?>
    func getHeldDetailData(heldNumber: Int) -> Single<Held?>
    func getTotoRateData(heldNumber: Int) -> Single<([Frame], [Rate])?>
    func getBookRateData(heldNumber: Int) -> Single<[Rate]?>
    func getHeld() -> Held?
    func saveHeld(_ held: Held) -> Bool
}
