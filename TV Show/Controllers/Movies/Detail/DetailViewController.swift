//
//  DetailViewController.swift
//  TV Show
//
//  Created by Hao Kim on 11/25/20.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    //MARK: -Properties
    private var viewModel: DetailViewModel!
    private let pickerView = UIView()
    private let datePicker = UIDatePicker()
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratinglabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var creditsCollectionView: UICollectionView!
    @IBOutlet weak var reminderButton: UIButton!
    
    // MARK: - Initialize
    
    init(movieID: Int) {
        viewModel = DetailViewModel(movieID: movieID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Public Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchMovieDetail() { (done, msg)  in
            if done {
                self.title = self.viewModel.movieDetail?.title
//                let thumnail = self.viewModel.thumbnail
//                if let thumnail = thumnail {
//                    self.posterImage.image = thumnail
//                }
                self.viewModel.getThumbnail(thumbnailPath: self.viewModel.movieDetail.posterPath) { (image) in
                    if let image = image {
                        self.posterImage.image = image
                    }
                }
                self.releaseDateLabel?.text = self.viewModel.movieDetail?.releaseDate
                self.ratinglabel?.text = self.viewModel.movieDetail!.imdb + "/10.0"
                self.overviewLabel?.text = self.viewModel.movieDetail?.overview
                self.updateUI()
            }
        }
        viewModel.fetchCredits() { (done, msg) in
            if done {
                self.updateUI()
            }
        }
    }
    //MARK: -Config
    override func setupData() {
    }
    override func setupUI() {
        super.setupUI()
        
        creditsCollectionView.delegate = self
        creditsCollectionView.dataSource = self
        creditsCollectionView.register(CasterCell.nib(), forCellWithReuseIdentifier: CasterCell.identifier)
        
        scrollView.addSubview(overviewLabel)
    }
    func updateUI() {
        creditsCollectionView.reloadData()
    }
    
    //MARK: -Action
    @IBAction func reminderTouchUpInside(_ sender: Any) {
        pickerView.isHidden = false
        pickerView.frame = CGRect(x: 0, y: view.frame.height - 300, width: view.frame.width, height: 260)
        pickerView.backgroundColor = UIColor.black
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = UIColor.white
        datePicker.frame = CGRect(x: 0, y: 0, width: pickerView.frame.width, height: pickerView.frame.height - 60)

        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: pickerView.frame.height - 44, width: pickerView.frame.width, height: 44))
        toolbar.isTranslucent = false
        toolbar.backgroundColor = UIColor.red
 
        
        let cancelButton = UIBarButtonItem(title: "Cancle", style: .plain, target: self, action: #selector(cancelPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let selectButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectedPicker))
        
        toolbar.setItems([cancelButton, spaceButton, selectButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        toolbar.resignFirstResponder()
        
        pickerView.addSubview(toolbar)
        pickerView.addSubview(datePicker)
        self.view.addSubview(pickerView)
        
        pickerView.bringSubviewToFront(self.view)
            
    }
    @objc func selectedPicker() {
        print("has pressed the Select button")
        
        pickerView.isHidden = true
    }
    @objc func cancelPicker() {
        print("has pressed the Cancel button")
        pickerView.isHidden = true
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CasterCell.identifier, for: indexPath) as! CasterCell
        
//        cell.binding(for: viewModel)
        cell.castNameLabel.text = viewModel.credits[indexPath.row].castName
        viewModel.getThumbnail(thumbnailPath: viewModel.credits[indexPath.row].profilePath) { image in
            if let image = image {
                cell.castImage.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
}
