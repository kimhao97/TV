//
//  FavoritesViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/27/20.
//

import Foundation
import RealmSwift

class FavoritesViewModel {
    var favorites: [Favorite] = []

    func fetchData(completion: Completion) {
        do {
            let realm = try! Realm()
            
            let results = realm.objects(Favorite.self)
            
            favorites = Array(results)
            
            completion(true, "")
        } catch {
            completion(false, "Realm cant fetch data")
        }
    }
    func deleteItem(favorite: Favorite) {
        let realm = try! Realm()
        
        let itemDelete = realm.objects(Favorite.self).filter("id == %@", favorite.id)
        try! realm.write {
            realm.delete(itemDelete)
        }
    }
}
