//
//  UICollectionViewCell+ReusableIdentifier.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 17/12/2022.
//

import UIKit

public extension UICollectionViewCell {
    /// Creates a generic identifier for the UICollectionViewCell depending on it's name/title.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
