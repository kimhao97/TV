//
//  UserViewController.swift
//  TV Show
//
//  Created by Hao Kim on 12/5/20.
//

import UIKit

class UserViewController: BaseViewController {
    let viewModel = UserViewModel()
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
       
        viewModel.fetchData() { (done, msg) in
            if done {
                let item = viewModel.user
                if let img = item.photo {
                    userImage.image = UIImage(data: img as Data)
                }
                userNameLabel.text = item.name
                birthdateLabel.text = item.birthDate
                mailLabel.text = item.email
                genderLabel.text = item.gender
            } else {
                print("Error: fecth data")
            }
        }
    }
    override func setupData() {

    }
    override func setupUI() {
        super.setupUI()
        
    }
    
    @IBAction func editTouch(_ sender: Any) {
        let vc = EditViewController()
        
        //vc.viewModel.user = viewModel.user // Error
        
        let item = viewModel.user
        vc.viewModel.user.name = item.name
        vc.viewModel.user.birthDate = item.birthDate
        vc.viewModel.user.email = item.email
        vc.viewModel.user.gender = item.gender
        vc.viewModel.user.photo = item.photo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}