//
//  GridCell.swift
//  TV Show
//
//  Created by Hao Kim on 12/9/20.
//

import UIKit

class GridCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func binding(with cell: MovieCellModel) {
        titleLabel.text = cell.getTitle()
        cell.getThumbnail() { (image) in
            if let image = image {
                self.userImage.image = image
            }
        }
    }

}
