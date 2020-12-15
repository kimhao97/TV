//
//  Settings.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class Settings: BaseViewController {
    let headerSection: [String] = ["Filter", "Sort By"]
    let namesCell: [[String]] = [
    ["Popular Movies", "Top Rated Movies", "Upcoming Movies", "NowPlaying Movies", "", ""],
    ["Release Date", "Rating"] ]
    let viewModel = SettingsViewModel()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
    }
    override func setupData() {
        
    }
    override func setupUI() {
        super.setupUI()
        title = "Settings"
        
        tableview.delegate = self
        tableview.dataSource = self
        
        let nib = UINib(nibName: "SettingCell", bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        tableview.register(ReleaseYearCell.nid(), forCellReuseIdentifier: ReleaseYearCell.identifier)
    }
    
    func updateUI() {
        tableview.reloadData()
    }
}

extension Settings: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= 4 {
            let cell = tableview.dequeueReusableCell(withIdentifier: ReleaseYearCell.identifier) as! ReleaseYearCell
            return cell
        }
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingCell

        let nameOfCell = namesCell[indexPath.section][indexPath.row]
        
        cell.binding(with: SettingCellModel(nameOfCell: nameOfCell))
        cell.cellAction = { (isPressed) in
            if isPressed {
                self.viewModel.selected(section: indexPath.section, select: nameOfCell)
                self.updateUI()
            }
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return namesCell.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesCell[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerSection[section]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
