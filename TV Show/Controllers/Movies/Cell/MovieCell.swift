//
//  MovieCell.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class MovieCell: UITableViewCell {
    //closure
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
    
    @IBAction func favoriteButton(_ sender: Any) {
        if favoriteButton.currentImage == UIImage(systemName: "star.fill") {
            favoriteButton.setImage(UIImage(systemName: "star"), for: UIControl.State.normal)
            cellAction?(false)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: UIControl.State.normal)
           cellAction?(true)
        }

    }
    func binding(with cell: MovieCellModel) {
        titleLabel.text = cell.getTitle()
        releaseDateLabel.text = cell.getReleaseDate()
        ratingLabel.text = cell.getRating()
        overviewLabel.text = cell.getOverview()
        posterImage.image = cell.getThumbnail()
        favoriteButton.setImage(cell.getFavoriteImage(), for: UIControl.State.normal)
    }
//    //MARK: IndexPath
//    func getIndexPath() -> IndexPath? {
//        guard let superView = self.superview as? UITableView else {
//            print("SuperView is not UITableView")
//            return nil
//        }
//        let indexPath = superView.indexPath(for: self)
//        return indexPath
//    }
    
}
