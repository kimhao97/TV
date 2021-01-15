//
//  Favorites.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class Favorites: BaseViewController {
    //MARK: -Properties
    let viewModel = FavoritesViewModel()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func setupData() {
    }
    override func setupUI() {
        super.setupUI()
        self.title = "Favorites"
        
        tableview.delegate = self
        tableview.dataSource = self

        tableview.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
                       
    }
    func updateUI() {
        tableview.reloadData()
        
        if let tabBarItem = SceneDelegate.shared().tabBarController.tabBar.items {
            tabBarItem[1].badgeValue = "\(viewModel.favorites.count)"
        }
    }
    func loadData() {
        viewModel.fetchData() { (done, msg) in
            if done {
                self.updateUI()
            } else {
                print("Fetch data error: \(msg)")
            }
        }
    }
}

extension Favorites: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: MovieCell = tableview.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        let item = viewModel.favorites[indexPath.row]
        cell.binding(with: MovieCellModel(movie: item))
        
        //MARK: -Favorite button
        cell.cellAction = { (isFavorite) in
            if isFavorite {
                
            } else {
                self.showAlert(message: "Are you sure you want to unfavorite this item") { (isOK, msg) in
                    if isOK {
                        self.viewModel.deleteItem(favorite: item)
                        self.loadData()
                    } else {
                        self.updateUI()
                    }
                }
            }
           
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.favorites[indexPath.row]
        let vc = DetailViewController(movieID: item.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
