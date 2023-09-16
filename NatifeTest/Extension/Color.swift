//
//  Color.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = UIColor(named: "AccentColor")
    let background = UIColor(named: "Background")
    let contentBlock = UIColor(named: "ContentBlock")
    let secondaryText = UIColor(named: "SecondaryText")
}
