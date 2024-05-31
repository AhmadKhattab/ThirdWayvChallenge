//
//  Array+ToDaomain.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation

extension Array where Element == Product {
    func toDomain() -> [ProductDataModel] {
        self.map { $0.toDomain() }
    }
}
