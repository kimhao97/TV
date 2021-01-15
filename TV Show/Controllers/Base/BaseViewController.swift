//
//  BaseViewController.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    //MARK: -Properties
//    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    //MARK: -Config
    func setupUI(){
        
    }
    func setupData() {
        
    }
    
    //MARK: -Public func
    func showAlert(message: String, completion: @escaping Completion) {
        let dialogMessage = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            completion(true, "")

        })
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
            completion(false, "")
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        present(dialogMessage, animated: true, completion: nil)
    }
    
//    func showDatePicker(textField: UITextField?, cancel: Selector?, select: Selector?) {
//        datePicker.datePickerMode = .date
//
////        datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
//        datePicker.preferredDatePickerStyle = .wheels
//
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let cancelButton = UIBarButtonItem(title: "Cancle", style: .plain, target: self, action: cancel)
//        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//        let selectButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: select)
//
//        toolbar.setItems([cancelButton, space, selectButton], animated: true)
//
//        if let textField = textField {
//            textField.inputAccessoryView = toolbar
//            textField.inputView = datePicker
//        }
//    }
}
