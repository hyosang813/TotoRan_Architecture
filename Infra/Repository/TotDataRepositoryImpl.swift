//
//  TotoDataRepositoryImpl.swift
//  Infra
//
//  Created by 丁孝相 on 2020/03/10.
//  Copyright © 2020 kosou.tei. All rights reserved.
//

import Alamofire
import Domain
import RxSwift


public class TotoDataRepositoryImpl {
    
    let DBNAME = "toto.db"
    
    // Databaseファイルの作成
    public func createDataBase() -> Bool {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let databasePath = documentsPath.appending(DBNAME)
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: databasePath) {
            return true
        }
        
        guard let path = Bundle.main.resourcePath?.appending(DBNAME) else {
            return false
        }
        
        do {
            try fileManager.copyItem(atPath: path, toPath: databasePath)
        } catch {
            return false
        }
        
        return true
    }
}
