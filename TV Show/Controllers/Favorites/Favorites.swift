//
//  Favorites.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class Favorites: BaseViewController {

    var favorites: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    override func setupData() {
        
    }
    override func setupUI() {
        super.setupUI()
        self.title = "Favorites"
        
        let nib = UINib(nibName: "MoveCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension Favorites: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        let item = favorites[indexPath.row]
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
    
    
}
