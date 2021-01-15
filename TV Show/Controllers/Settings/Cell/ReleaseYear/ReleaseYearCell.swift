//
//  ReleaseYearCell.swift
//  TV Show
//
//  Created by Hao Kim on 12/15/20.
//

import UIKit

class ReleaseYearCell: UITableViewCell {

    @IBOutlet weak var releaseYearTextField: UITextField!
      
    var datePicker = UIDatePicker()
    static let identifier: String = "ReleaseYearCell"
    static func nib() -> UINib {
        return UINib(nibName: "ReleaseYearCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func releaseYearPessed(_ sender: Any) {
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let selectButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: nil)
        toolBar.setItems([cancelButton, spaceButton, selectButton], animated: false)
        
        releaseYearTextField.inputAccessoryView = toolBar
        releaseYearTextField.inputView = datePicker
    }
    
}
