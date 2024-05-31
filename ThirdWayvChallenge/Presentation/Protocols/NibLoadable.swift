//
//  NibLoadable.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 17/12/2022.
//

import UIKit

protocol NibLoadable: AnyObject {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
