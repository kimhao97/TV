//
//  RatingCell.swift
//  TV Show
//
import Foundation
import UIKit
import RealmSwift

class RatingCell: UITableViewCell {
    //MARK: -properties
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var slider: UISlider!

    static let identifier: String = "RatingCell"
    static func nib() -> UINib {
        return UINib(nibName: "RatingCell", bundle: nil)
    }
    
    var rating: Float = 0{
        didSet {
            ratingLabel.text = "\(rating)"
            viewModel.updateSettingRealm(rating, for: .rating)
        }
    }
    let viewModel = SettingCellModel(nameOfCell: "Rating")
    //MARK: -public func
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingLabel.text = "\(rating)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func slideTouchInside(_ sender: Any) {
        rating = (slider.value*10).rounded()/10
    }
}
