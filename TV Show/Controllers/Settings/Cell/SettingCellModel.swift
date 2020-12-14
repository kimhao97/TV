//
//  SettingCellModel.swift
//  TV Show
//
//  Created by Hao Kim on 12/11/20.
//

import Foundation
import UIKit
import RealmSwift
class SettingCellModel {
    var nameOfCell: String
    var checkImage: UIImage?
    var setting = Setting()
    init(nameOfCell: String) {
        self.nameOfCell = nameOfCell
    }
    func getTitle() -> String {
        return self.nameOfCell
    }
    func getThumbnail() -> UIImage? {
        fetchSettingData()
        if nameOfCell == setting.nameFilter || nameOfCell == setting.nameSort{
            return UIImage(systemName: "checkmark")
        } else {
            return nil
        }
    }
    func fetchSettingData() {
        let realm = try! Realm()
        
        let results = realm.objects(Setting.self)
        
        setting = results[0]
    }
}
