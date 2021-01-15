//
//  CasterCell.swift
//  TV Show
//
//  Created by Hao Kim on 12/31/20.
//

import UIKit

class CasterCell: UICollectionViewCell {
    //MARK: -Properties
    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    static let identifier: String = "CasterCell"
    static func nib() -> UINib {
        return UINib(nibName: "CasterCell", bundle: nil)
    }
    //MARK: -Public func
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func binding(for cell: DetailViewModel) {
//        castNameLabel.text = cell.
        
    }
}
