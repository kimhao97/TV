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
            
            for result in results {
                self.favorites.append(result)
                
            }
            for item in favorites {
                print(item.title)
            }
            
            completion(true, "")
        } catch {
            completion(false, "Realm cant fetch data")
        }
    }
    
//    //singleton pattern
//    private static var sharedFavorite: FavoritesViewModel = {
//        let favoritesViewModel = FavoritesViewModel()
//        return favoritesViewModel
//    }()
//    class func shared() -> FavoritesViewModel {
//        return sharedFavorite
//    }
//    private init() {}
//    var favorites: [Movie] = []
//    weak var dataSource: FavoriteViewDataSource?
////    var favoriteAction: (() -> [Movie])?
//    func fetchData(completion: @escaping Completion) -> Void {
////        favorites = favoriteAction!()
//        if let dataSource = dataSource {
////            self.favorites = dataSource.getData()
//            completion(true, "")
//        } else {
//            completion(false, "Favorites has not data")
//        }
//
//    }
}
