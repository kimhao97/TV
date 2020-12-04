//
//  About.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit
import WebKit

class About: BaseViewController {

    @IBOutlet weak var web: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func setupData() {
        
    }
    override func setupUI() {
        super.setupUI()
        self.title = "About"
        let urlString = "https://www.themoviedb.org/about"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        web.load(request)
    }
}
