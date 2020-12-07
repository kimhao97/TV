//
//  User.swift
//  TV Show
//
//  Created by Hao Kim on 12/5/20.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var birthDate: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var photo: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
