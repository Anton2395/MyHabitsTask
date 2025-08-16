//
//  UIColor+Extention.swift
//  MyHabits
//
//  Created by Toha Shilin on 16.08.25.
//
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
