//
//  SettingCell.swift
//  TV Show
//
//  Created by Hao Kim on 12/11/20.
//

import UIKit

class SettingCell: UITableViewCell {
    var cellAction: ((Bool) -> ())?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func selectCell(_ sender: Any) {
        if selectImage.image == nil {
//            selectImage.image = UIImage(systemName: "checkmark")
            cellAction!(true)
        } else {
//            selectImage.image = nil
//            cellAction!(false)
        }
    }
    
    func binding(with cell: SettingCellModel) {
        titleLabel.text = cell.getTitle()
        selectImage.image = cell.getThumbnail()
    }
}
