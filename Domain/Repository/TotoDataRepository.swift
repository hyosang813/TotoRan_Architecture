//
//  TotoDataRepository.swift
//  TotoRan
//  Infra層のRepositoryへのInterFace
//
//  Created by kosou.tei on 2021/05/13.
//

import Combine

public protocol TotoDataRepository {
    func getHeldData() -> Future<Int? ,Error>
    func getHeldDetailData(heldNumber: Int) -> Future<Held?, Error>
    func getTotoRateData(heldNumber: Int) -> Future<([Frame], [Rate])?, Error>
    func getBookRateData(heldNumber: Int) -> Future<[Rate]?, Error>
    func getHeld() -> Held?
    func saveHeld(_ held: Held) -> Bool
}
