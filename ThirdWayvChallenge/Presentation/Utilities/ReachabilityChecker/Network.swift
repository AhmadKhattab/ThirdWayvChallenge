//
//  Network.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation

struct Network {
    static var reachability: Reachability!
    enum Status: String {
        case unreachable, wifi, wwan
    }
    enum Error: Swift.Error {
        case failedToSetCallout
        case failedToSetDispatchQueue
        case failedToCreateWith(String)
        case failedToInitializeWith(sockaddr_in)
    }
}
