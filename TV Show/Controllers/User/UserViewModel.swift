//
//  UserViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 12/6/20.
//

import Foundation
import RealmSwift

class UserViewModel {
    var user = User()
    
    func fetchData(completion: Completion) {
        do {
            let realm = try! Realm()
            
            let results = realm.objects(User.self)
            if (results.count != 0) {
                user = results[0]
                completion(true, "")
            } else {
                completion(false, "Realm cant fetch data")
            }
        } catch {
            completion(false, "Realm cant fetch data")
        }
    }
}
