//
//  FavoritesViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/27/20.
//

import Foundation
import RealmSwift

//protocol FavoriteViewDataSource: class {
//    func getData() -> [Movie]
//}
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
}
