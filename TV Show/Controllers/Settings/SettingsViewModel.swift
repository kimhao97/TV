//
//  SettingsViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 12/10/20.
//

import Foundation
import RealmSwift
class SettingsViewModel {
    let setting = Setting()
    
    func selected(section: Int, select: String) {
        switch select {
        case "Popular Movies":
            setting.filterType = SettingType.FilterType.popular.rawValue
        case "Top Rated Movies":
            setting.filterType = SettingType.FilterType.topRated.rawValue
        case "Upcoming Movies":
            setting.filterType = SettingType.FilterType.upcoming.rawValue
        case "NowPlaying Movies":
            setting.filterType = SettingType.FilterType.nowPlaying.rawValue
        case "Release Date":
            setting.sortBy = SettingType.SortByType.releaseDate.rawValue
        case "Rating":
            setting.sortBy = SettingType.SortByType.rating.rawValue
        default:
            break
        }
        updateSettingRealm(section: section)
    }
    func updateSettingRealm(section: Int) {
        let realm = try! Realm()

        let results = realm.objects(Setting.self)
        
        switch section {
        case 0:
            try! realm.write {
                results[0].filterType = setting.filterType
                results[0].nameFilter = setting.nameFilter
            }
        case 1:
            try! realm.write {
                results[0].sortBy = setting.sortBy
                results[0].nameSort = setting.nameSort
            }
        default:
            break
        }

    }
}
