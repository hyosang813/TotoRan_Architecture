//
//  TotoDataRepositoryImpl.swift
//  Infra
//
//  Created by 丁孝相 on 2020/03/10.
//  Copyright © 2020 kosou.tei. All rights reserved.
//

import Alamofire
import Kanna
import Domain
import RxSwift


public class TotoDataRepositoryImpl {
    
    let DBNAME = "toto.db"
    
    enum CustomError: Error {
        case unknown
    }

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
    
    // 開催回データ取得
    public func getKaisaiData() -> Completable {
        let KAISAI_URL = "https://toto.rakuten.co.jp/toto/schedule/"
        do {
            return Completable.create { subscriber in
                Alamofire.request(KAISAI_URL).responseString { response in
                    switch response.result {
                    case .success:
                        guard let html = response.result.value, self.parseKaisaiHTML(html: html) else {
                            subscriber(.error(CustomError.unknown))
                            return
                        }
                        subscriber(.completed)
                    case .failure(let error):
                        subscriber(.error(error))
                    }
                }
                return Disposables.create()
            }
        } catch {
            return Completable.create { subscriber in
                subscriber(.error(error))
                return Disposables.create()
            }
        }
    }
    
    // 開催回データのパースとDB保存処理
    private func parseKaisaiHTML(html: String) -> Bool {
        if let doc = try? HTML(html: html, encoding: .utf8) {
            print(doc.title)
            
            for link in doc.css("a, link") {
                print(link.text)
                print(link["href"])
            }
        }
        return true // とりあえず
    }
}
