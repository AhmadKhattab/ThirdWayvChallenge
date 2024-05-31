//
//  UICollectionView+Registeration.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 17/12/2022.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_: Cell.Type) where Cell: NibLoadable {
        self.register(UINib(nibName: Cell.nibName, bundle: nil), forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }
}
