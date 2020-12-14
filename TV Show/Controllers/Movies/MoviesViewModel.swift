//
//  MoviesViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import Foundation
import RealmSwift

typealias  Completion = (Bool, String) -> Void

class MoviesViewModel {
    var movies: [Movie] = []
    var setting = Setting()
    var filterType: SettingType.FilterType = .popular
    var sortByType: SettingType.SortByType?
    //MARK: -load API
    func loadAPI(completion: @escaping Completion) -> Void {
        
        let urlString: String = SettingType.FilterType.baseURL + self.filterType.path
        
        Networking.shared().request(with: urlString) {(data, error) in
            if let error = error {
                //callback
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSON()
//                    let feed = json["feed"] as! JSON //check it
                    let results = json["results"] as! [JSON]
                    self.movies.removeAll()
                    for item in results {
                        let movie = Movie(json: item)
                        self.movies.append(movie)
                    }
                    completion(true, "")
                } else {
                    completion(false, "Data format is error")
                }
            }
        }
    }
    func sorted() {
        if let sortByType = sortByType {
            var count: Int = movies.count
            var index: Int = 0
            switch sortByType {
            case .releaseDate:
                repeat {
                    let item = movies[index].releaseDate
                    let year = getYearToInt(relaseDate: item)
                    if year < setting.releaseYear {
                        movies.remove(at: index)
                        count -= 1
                    } else {
                        index += 1
                    }
                } while index < count
            case .rating:
//                for (index, element) in movies.enumerated() {
//                    if element.rating < setting.rating {
//                        movies.remove(at: index)
//                    }
//                }
                repeat {
                    if movies[index].rating < setting.rating {
                        movies.remove(at: index)
                        count -= 1
                    } else {
                        index += 1
                    }
                } while index < count
            }
        }
    }
    func getYearToInt(relaseDate: String) -> Int {
        
        let endOfSentence = relaseDate.firstIndex(of: "-") ?? relaseDate.startIndex
        let firstSentence = relaseDate[..<endOfSentence]
        let year = Int(firstSentence) ?? 0
        
        return year
    }
    //MARK: -realmData
    func fectchSetting() {
        let realm = try! Realm()
        let results = realm.objects(Setting.self)
        
        setting = results[0]
        switch setting.filterType {
        case SettingType.FilterType.popular.rawValue:
            filterType = SettingType.FilterType.popular
        case SettingType.FilterType.topRated.rawValue:
            filterType = SettingType.FilterType.topRated
        case SettingType.FilterType.upcoming.rawValue:
            filterType = SettingType.FilterType.upcoming
        case SettingType.FilterType.nowPlaying.rawValue:
            filterType = SettingType.FilterType.nowPlaying
        default:
            break
        }
        
        switch setting.sortBy {
        case SettingType.SortByType.releaseDate.rawValue:
            sortByType = SettingType.SortByType.releaseDate
        case SettingType.SortByType.rating.rawValue:
            sortByType = SettingType.SortByType.rating
        default:
           break
        }
    }
    func addFavorite(movie: Movie) {
        let realm = try! Realm()
        
        let favorite = Favorite()
        favorite.title = movie.title
        favorite.releaseDate = movie.releaseDate
        favorite.overview = movie.overview
        favorite.rating = movie.rating
        favorite.posterpath = movie.posterpath
//        favorite.posterImage = movie.posterImage
        favorite.id = movie.id
        
        try! realm.write {
            realm.add(favorite)
        }
    }
    func deleteItem(movie: Movie) {
        let realm = try! Realm()
        
        let itemDelete = realm.objects(Favorite.self).filter("id == %@", movie.id)
        try! realm.write {
            realm.delete(itemDelete)
        }
    }
    func deleteAllFavorite(completion: Completion) {
        do {
            let realm = try! Realm()
            
            let results = realm.objects(Favorite.self)
            
            try realm.write {
                realm.delete(results)
            }
            completion(true, "")
        } catch  {
            completion(false, "Cant delete all item")
        }
    }
     

}
