//
//  User.swift
//  TV Show
//
//  Created by Hao Kim on 12/5/20.
//

import Foundation
import RealmSwift

final class User: Object {
    @objc dynamic var name: String = "John Marker"
    @objc dynamic var birthDate: String = "1-1-1970"
    @objc dynamic var email: String = "johnmarker@gmail.com"
    @objc dynamic var gender: String = "Male"
    @objc dynamic var photo: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
