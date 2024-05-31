//
//  Encodable+ConvertToData.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation

extension Encodable {
    func convertToData() -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(self)
        return data ?? nil
    }
}
