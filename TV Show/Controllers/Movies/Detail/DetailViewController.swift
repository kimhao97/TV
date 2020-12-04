//
//  DetailViewController.swift
//  TV Show
//
//  Created by Hao Kim on 11/25/20.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratinglabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    let moviesViewModel = MoviesViewModel()
    let detailViewModel = DetailViewModel()

    var viewModel = DetailViewModel()
    
    var realeaseDate: String = ""
    var rating: Float = 0
    var overview: String = ""
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
        releaseDateLabel?.text = viewModel.movieDetail?.releaseDate
        ratinglabel?.text = viewModel.movieDetail!.imdb + "/10.0"
        overviewLabel?.text = viewModel.movieDetail?.overview
    }
    @IBAction func reminder(_ sender: Any) {
    }
    
}
