//
//  EditViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 12/6/20.
//

import Foundation
import RealmSwift

class EditViewModel {
    var user = User()
    func saveUserData() {
        let realm = try! Realm()
        
        let results = realm.objects(User.self)
        try! realm.write {
            realm.delete(results)
            realm.add(user)
        }
    }
//    func deleteAll() {
//        do {
//            let realm = try! Realm()
//
//            let results = realm.objects(User.self)
//
//            try! realm.write {
//                realm.delete(results)
//            }
//        } catch {
//
//        }
//    }
}
