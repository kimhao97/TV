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
            
            user = results[0]
            
            completion(true, "")
        } catch {
            completion(false, "Realm cant fetch data")
        }
    }
}
