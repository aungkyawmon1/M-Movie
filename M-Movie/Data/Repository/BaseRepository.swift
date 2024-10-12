//
//  BaseRepository.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import RealmSwift
import RxSwift

class BaseRepository: NSObject {
    
    override init() {
        super.init()
    }
    let disposeBag = DisposeBag()
    
    let realmInstance = try! Realm()

    func clearAllData() {
        // Delete all objects from the realm
        do {
            try realmInstance.write {
                realmInstance.deleteAll()
            }
        } catch {
            debugPrint("Something went wrong!")
        }
        
    }
    
}
