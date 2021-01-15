//
//  MovieCell.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class MovieCell: UITableViewCell {
    //MARK: -Properties
    static let identifier: String = "MovieCell"
    static func nib() -> UINib {
        return UINib(nibName: "MovieCell", bundle: nil)
    }
    var cellAction:((Bool) -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: -Action
    @IBAction func favoriteButton(_ sender: Any) {
        if favoriteButton.currentImage == UIImage(systemName: "star.fill") {
            favoriteButton.setImage(UIImage(systemName: "star"), for: UIControl.State.normal)
            cellAction?(false)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: UIControl.State.normal)
           cellAction?(true)
        }

    }
    //MARK: -Config
    func binding(with cell: MovieCellModel) {
        titleLabel.text = cell.getTitle()
        releaseDateLabel.text = cell.getReleaseDate()
        ratingLabel.text = cell.getRating()
        overviewLabel.text = cell.getOverview()
        cell.getThumbnail() { (image) in
            if let image = image {
                self.posterImage.image = image
            }
        }
        favoriteButton.setImage(cell.getFavoriteImage(), for: UIControl.State.normal)
    }    
}
