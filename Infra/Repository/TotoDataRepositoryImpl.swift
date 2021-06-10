//
//  RemoteDataSource.swift
//  TotoRan
//  Repository
//
//  Created by kosou.tei on 2021/05/13.
//

import RxSwift
import Domain

public class TotoDataRepositoryImpl: TotoDataRepository {
    
    let localDataSource = LocalDataSource()
    let remoteDataSource = RemoteDataSource()

    // 開催回データ取得
    public func getHeldData() -> Single<Int?> {
        remoteDataSource.getHeldData()
    }

    // 開催詳細データ取得
    public func getHeldDetailData(heldNumber: Int) -> Single<Held?> {
        remoteDataSource.getHeldDetailData(heldNumber: heldNumber)
    }

    // Toto支持率データ取得
    public func getTotoRateData(heldNumber: Int) -> Single<([Frame], [Rate])?> {
        remoteDataSource.getTotoRateData(heldNumber: heldNumber)
    }

    // Book支持率データ取得
    public func getBookRateData(heldNumber: Int) -> Single<[Rate]?> {
        remoteDataSource.getBookRateData(heldNumber: heldNumber)
    }
    
    // ローカルにデータ保存
    public func getHeld() -> Held? {
        localDataSource.getHeld()
    }
    
    // ローカルからデータ取得
    public func saveHeld(_ held: Held) -> Bool {
        localDataSource.saveHeld(held)
    }
}
