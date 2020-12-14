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
    var selectRight: UIBarButtonItem?
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var gridview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fectchSetting()
        viewModel.loadAPI() { (done, msg) in
            if done {
                self.viewModel.sorted()
                self.updateUI()
            } else {
                print("API error: \(msg)")
            }
        }
    }
    override func setupData() {
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    override func setupUI() {
        super.setupUI()
        //title
        self.title = "Popular"
                
        //MARK: -table
        tableview.delegate = self
        tableview.dataSource = self
        tableview.alpha = 1
        //cell
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        
        //MARK: -grid
        gridview.delegate = self
        gridview.dataSource = self
        gridview.alpha = 0
        //cell
        let gridNib = UINib(nibName: "GridCell", bundle: nil)
        gridview.register(gridNib, forCellWithReuseIdentifier: "gridCell")
        

        
        //MARK: -side bar
        let menuLeft  = UIBarButtonItem(image: UIImage(named: "ic-menu"), style: .plain, target: self, action: #selector(menuAction))
        navigationItem.leftBarButtonItem = menuLeft
        
        selectRight = UIBarButtonItem(image: UIImage(named: "ic-collection"), style: .plain, target: self, action: #selector(selectViewAction))
        navigationItem.rightBarButtonItem = selectRight
        
        //side menu
        menu = SideMenuNavigationController(rootViewController: UserViewController())
        menu?.leftSide = true
        menu?.menuWidth = CGFloat(UIScreen.main.bounds.width * 4/5)
        
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: self.menu)
    }
    
    func updateUI() -> Void {
        tableview.reloadData()
        gridview.reloadData()
    }

    //MARK: -Menu action
    @objc func menuAction() {
        present(menu!, animated: true)
    }
    
    //MARK: -Select view action
    @objc func selectViewAction() {
        if tableview.alpha == 1 {
            selectRight?.image = UIImage(named: "ic-table")
            tableview.alpha = 0
            gridview.alpha = 1
        } else {
            selectRight?.image = UIImage(named: "ic-collection")
            tableview.alpha = 1
            gridview.alpha = 0
        }
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
                print(msg)
            }
        }
    }
}

extension Movies: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gridview.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! GridCell
        let item = viewModel.movies[indexPath.row]
        cell.binding(with: MovieCellModel(movie: item))
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.movies[indexPath.row]
        let vc = DetailViewController()

        vc.viewModel.loadAPI(movieID: item.id) { (done, msg) in
            if done {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                print(msg)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
