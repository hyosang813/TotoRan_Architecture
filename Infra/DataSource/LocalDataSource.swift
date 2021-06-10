//
//  LocalDataSource.swift
//  TotoRan
//  端末内のデータを保存、取得するDataSource
//
//  Created by kosou.tei on 2021/05/13.
//

import Disk
import Domain

class LocalDataSource {
    
    func saveHeld(_ held: Held) -> Bool {
        if let _ = try? Disk.save(held, to: .documents, as: "held.json") {
            return true
        } else {
            return false
        }
    }
    
    func getHeld() -> Held? {
        if let held = try? Disk.retrieve("held.json", from: .documents, as: Held.self) {
            return held
        } else {
            return nil
        }
    }
}
