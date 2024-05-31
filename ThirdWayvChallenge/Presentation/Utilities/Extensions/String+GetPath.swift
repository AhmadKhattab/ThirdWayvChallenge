//
//  String+GetPath.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation

extension String {
    
    
    /// Get the full path of folder by appending "folderName"
    /// - Parameter folderName: it will be appended to the path used for saving
    /// - Returns: the full url which used to saving
    func getPath(using folderName: String) -> URL? {
        var fullPath =  try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

        fullPath = fullPath?.appendingPathComponent(folderName)
        if !self.isEmpty {
            fullPath = fullPath?.appendingPathComponent(self)
        }
        if !FileManager.default.fileExists(atPath: (fullPath?.path)!) {
            do {
                try FileManager.default.createDirectory(at: (fullPath?.deletingLastPathComponent())!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        return fullPath
    }
}
