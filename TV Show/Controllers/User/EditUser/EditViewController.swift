//
//  EditViewController.swift
//  TV Show
//
//  Created by Hao Kim on 12/5/20.
//

import UIKit

class EditViewController: BaseViewController {
    //MARK: -Properties
    let viewModel = EditViewModel()
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    
    //MARK: -Public func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func setupData() {
        
    }
    //MARK: -Config
    override func setupUI() {
        super.setupUI()

        userButton.layer.borderWidth = 10
        userButton.layer.borderColor = UIColor.lightGray.cgColor
        userButton.layer.cornerRadius = userButton.frame.width/2

        let item = viewModel.user
        if let img = item.photo {
//            userImage.image = UIImage(data: img as Data)
            userButton.setImage(UIImage(data: img as Data), for: .normal)
        }
        userNameTextField.text = item.name
        birthDateTextField.text = item.birthDate
        mailTextField.text = item.email
        
        //cancel tabbar
        let cancelLeft = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem = cancelLeft
        
        //save tabbar
        let saveRight = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = saveRight
        
    }
    
    //MARK: -Action
    @objc func cancelAction() {
        self.navigationController?.popViewController(animated: true)
//        let vc = Movies()
//        self.navigationController?.popToViewController(vc, animated: true)
    }
    @objc func saveAction() {
        self.navigationController?.popViewController(animated: true)
        
        viewModel.user.name = userNameTextField.text ?? "Anonymous"
        viewModel.user.birthDate = birthDateTextField.text ?? ""
        viewModel.user.email = mailTextField.text ?? "abc@gmail.com"
        viewModel.user.gender = ""
     
//        var data = userImage.image?.pngData()
        var data = userButton.image(for: .normal)?.pngData()
        if data == nil {
//            data = userImage.image?.jpegData(compressionQuality: 0.9)
            data = userButton.image(for: .normal)?.jpegData(compressionQuality: 0.9)
        }
        viewModel.user.photo = NSData(data: data!)

        viewModel.saveUserData()
    }
    
    //MARK: -Date picker
    @IBAction func birthDatePicker(_ sender: Any) {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()


        //bar button
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let selectButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectedPicker))
        toolbar.setItems([cancelButton, spaceButton, selectButton], animated: true)

        //add toolbar to textField
        birthDateTextField.inputAccessoryView = toolbar
        //add datePicker to textField
        birthDateTextField.inputView = datePicker
             
    }
    @objc func selectedPicker() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        birthDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    @objc func cancelPicker() {
        self.view.endEditing(true)
    }
    
    //MARK: -Picking image
    @IBAction func pickPhotoImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
//            userImage.image = image
            userButton.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
