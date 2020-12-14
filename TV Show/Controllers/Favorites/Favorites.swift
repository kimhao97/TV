//
//  Favorites.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class Favorites: BaseViewController {
    let viewModel = FavoritesViewModel()

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func setupData() {
//        super.setupData()
        
    }
    override func setupUI() {
        super.setupUI()
        self.title = "Favorites"
        
        tableview.delegate = self
        tableview.dataSource = self

        let nib = UINib(nibName: "MovieCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "Cell")
                       
    }
    func updateUI() {
        tableview.reloadData()
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

        let cell: MovieCell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        
        let item = viewModel.favorites[indexPath.row]
        cell.binding(with: MovieCellModel(movie: item))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.favorites[indexPath.row]
        let vc = DetailViewController()

        vc.viewModel.loadAPI(movieID: item.id) { (done, msg) in
            if done {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                print(msg)
            }
        }
    }
}
