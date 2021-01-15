//
//  Setting.swift
//  TV Show
//
//  Created by Hao Kim on 12/12/20.
//

import Foundation
import RealmSwift
final class Setting: Object {
    @objc dynamic var nameFilter: String = ""
    @objc dynamic var nameSort: String = ""
    @objc dynamic var filterType: Int = 0
    {
        didSet {
            switch filterType {
            case 0:
                nameFilter = "Popular Movies"
            case 1:
                nameFilter = "Top Rated Movies"
            case 2:
                nameFilter = "Upcoming Movies"
            case 3:
                nameFilter = "NowPlaying Movies"
            default:
                break
            }
        }
    }
    @objc dynamic var sortBy: Int = 0
    {
        didSet {
            switch sortBy {
            case 0:
                nameSort = "Release Date"
            case 1:
                nameSort = "Rating"
            default:
                break
            }
        }
    }
    @objc dynamic var rating: Float = 0
    @objc dynamic var releaseYear: Int = 1970
}
