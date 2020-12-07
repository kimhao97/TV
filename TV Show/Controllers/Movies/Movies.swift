//
//  Movies.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit
import RealmSwift
import SideMenu

class Movies: BaseViewController {
    let viewModel = MoviesViewModel()
    var menu: SideMenuNavigationController?
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func setupData() {
//        viewModel.deleteAllFavorite() { (done, msg) in
//            if done {
//                print("Deleted")
//            } else {
//                print(msg)
//            }
//        }
    }
    override func setupUI() {
        super.setupUI()
        //title
        self.title = "Movies"
                
        //MARK: -table
        tableview.delegate = self
        tableview.dataSource = self
        
        //cell
        let nib = UINib(nibName: "MovieCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        
        loadAPI()
        
        //MARK: -side bar
        let menuLeft  = UIBarButtonItem(image: UIImage(named: "ic-menu"), style: .plain, target: self, action: #selector(menuAction))
        navigationItem.leftBarButtonItem = menuLeft
        
        //side menu
        menu = SideMenuNavigationController(rootViewController: UserViewController())
        menu?.leftSide = true
        menu?.menuWidth = CGFloat(UIScreen.main.bounds.width * 4/5)
        
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: self.menu)
        

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
    //MARK: -Menu action
    @objc func menuAction() {
        present(menu!, animated: true)
    }
}

extension Movies: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        let item = viewModel.movies[indexPath.row]
        cell.binding(with: MovieCellModel(movie: item))
        
//        if item.posterImage != nil {
//            cell.posterImage.image = item.posterImage
//        } else {
//            cell.posterImage.image = item.posterImage
//            Networking.shared().download(url: "http://image.tmdb.org/t/p/w185/" + item.posterpath) { (image) in
//                print("PosterPath: \(item.posterpath)")
//                if let image = image {
//                    cell.posterImage.image = image
//                    item.posterImage = image
//                } else {
//                    cell.posterImage.image = nil
//                }
//            }
//        }

        //MARK: -favorite button
        cell.cellAction = { (butStatus) in
            if butStatus {
                self.viewModel.addFavorite(movie: item)
            } else {
                self.viewModel.deleteItem(movie: item)
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
//    func getData() -> [Movie] {
//        print("fetchData")
//        return nil
//    }
    
}
