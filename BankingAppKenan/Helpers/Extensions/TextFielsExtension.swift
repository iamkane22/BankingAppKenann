//
//  TextFielsExtension.swift
//  BankingAppKenan
//
//  Created by Kenan on 30.11.24.
//
import UIKit

extension UITextField {
    func setBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

