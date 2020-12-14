//
//  DetailViewController.swift
//  TV Show
//
//  Created by Hao Kim on 11/25/20.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratinglabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    override func setupData() {
    }
    override func setupUI() {
        super.setupUI()
        
        self.title = viewModel.movieDetail?.title
        viewModel.getThumbnail() { (image) in
            if let image = image {
                self.posterImage.image = image
            }
        }
        releaseDateLabel?.text = viewModel.movieDetail?.releaseDate
        ratinglabel?.text = viewModel.movieDetail!.imdb + "/10.0"
        overviewLabel?.text = viewModel.movieDetail?.overview
    }
    @IBAction func reminder(_ sender: Any) {
    }
    
}
