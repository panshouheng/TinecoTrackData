//
//  UITextFieldEx.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/25.
//

import Foundation

extension UITextField {
    static func create(placeholder: String?) -> UITextField {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.placeholder = placeholder
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 18)
        return tf
    }
}
