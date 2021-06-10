//
//  RepositoryProvider.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/14.
//

import Domain

public class RepositoryProvider {
    public init() {}
    public func provideTotoDataRepository() -> TotoDataRepository { TotoDataRepositoryImpl() }
}
