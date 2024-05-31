//
//  NetworkManagerProtocol.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func request<T: Decodable, E: EndPointType>(api: E, completion: @escaping (Result<T, NetworkError>) -> Void)
}
