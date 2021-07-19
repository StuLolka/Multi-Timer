//
//  ExtensionForTextField.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 08.07.2021.
//

import UIKit

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTimerTextField {
            timeInSecTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.layer.borderColor != UIColor.gray.cgColor {
            textField.layer.borderColor =  UIColor.gray.cgColor
            textField.text = ""
        }
    }
}
