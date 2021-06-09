//
//  RemoteDataSource.swift
//  TotoRan
//  http通信をして外部がらデータを取得するDataSource
//
//  Created by kosou.tei on 2021/05/13.
//
import Alamofire
import RxSwift

class RemoteDataSource {
    // 開催回データ取得
    public func getHeldData() -> Single<Int?> {
        let url = "https://toto.rakuten.co.jp/toto/schedule/"
        return Single.create { subscriber in
            AF.request(url).responseString { response in
                switch response.result {
                case .success(let html):
                    subscriber(.success(HeldMapper.parseHeld(html: html)))
                case .failure(let error):
                    subscriber(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    // 開催詳細データ取得
    public func getHeldDetailData(heldNumber: Int) -> Single<Held?> {
        let url = "https://store.toto-dream.com/dcs/subos/screen/pi01/spin000/PGSPIN00001DisptotoLotInfo.form?holdCntId=\(heldNumber)"
        return Single.create { subscriber in
            AF.request(url).responseString { response in
                switch response.result {
                case .success(let html):
                    subscriber(.success(HeldDetailMapper.parseHeldDetail(heldNumber: heldNumber, html: html)))
                case .failure(let error):
                    subscriber(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    // Toto支持率データ取得
    public func getTotoRateData(heldNumber: Int) -> Single<([Frame], [Rate])?> {
        let url = "https://store.toto-dream.com/dcs/subos/screen/pi09/spin003/PGSPIN00301InitVoteRate.form?holdCntId=\(heldNumber)&commodityId=01"
        return Single.create { subscriber in
            AF.request(url).responseString { response in
                switch response.result {
                case .success(let html):
                    subscriber(.success(TotoRateMapper.parseTotoRate(html: html, heldNumber: heldNumber)))
                case .failure(let error):
                    subscriber(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    // Book支持率データ取得
    public func getBookRateData(heldNumber: Int) -> Single<[Rate]?> {
        // Bookデータのサイトがhttps対応してないのでATS無効にしてるけど、おそらくこれでは審査通らないね
        let url = "http://tobakushi.net/toto/tototimes/bg_\(heldNumber).html"
        return Single.create { subscriber in
            AF.request(url).responseString { response in
                switch response.result {
                case .success(let html):
                    subscriber(.success(BookRateMapper.parseBookRate(html: html, heldNumber: heldNumber)))
                case .failure(let error):
                    subscriber(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
