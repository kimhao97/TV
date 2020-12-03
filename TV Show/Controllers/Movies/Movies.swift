//
//  Movies.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class Movies: BaseViewController {
    var viewModel = MoviesViewModel()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func setupUI() {
        super.setupUI()
        //title
        self.title = "Movies"
        
        //table
        tableview.delegate = self
        tableview.dataSource = self
        
        
        //cell
        let nib = UINib(nibName: "MovieCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        
        loadAPI()
    }
    func updateUI() -> Void {
        tableview.reloadData()
    }
    func loadAPI() -> Void {
        viewModel.loadAPI() { (done, msg) in
            if done {
                self.updateUI()
            } else {
                print("API error: \(msg)")
            }
        }
    }
}

extension Movies: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        let item = viewModel.movies[indexPath.row]
        cell.titleLabel.text = item.title
        cell.releaseDateLabel.text = item.releaseDate
        cell.overviewLabel.text = item.overview
        cell.ratingLabel.text = "\(item.rating)"
        if item.posterImage != nil {
            cell.posterImage.image = item.posterImage
        } else {
            cell.posterImage.image = item.posterImage
            Networking.shared().download(url: "http://image.tmdb.org/t/p/w185/\(item.posterpath)") { (image) in
                print("PosterPath: \(item.posterpath)")
                if let image = image {
                    cell.posterImage.image = image
                    item.posterImage = image
                } else {
                    cell.posterImage.image = nil
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.movies[indexPath.row]
        let vc = DetailViewController()
        vc.viewModel.loadAPI(movieID: item.id) { (done, msg) in
            if done {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                print("Movie detail error")
            }
        }
    }
    
}
