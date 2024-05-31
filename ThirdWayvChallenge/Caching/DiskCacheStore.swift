//
//  DiskCacheStore.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation

/// DiskCacheStore is a class responsible for caching
class DiskCacheStore {
    // MARK: - Properties
    static let shared: DiskCacheStore = {
        let diskCacheStore = DiskCacheStore()
        return diskCacheStore
    }()
    // MARK: - Initializer(s)
    private init() { }
    // MARK: - Handling Caching Method(s)
    
    /// Saves a given object to disk at the path specified by "fileName" parameter.
    /// - Parameters:
    ///   - object: The object to save
    ///   - filePath: The path to save at
    /// - Returns: true if the object was saved successfully, or false in case of failure.
    fileprivate func saveToDisk(object: Any, filePath: URL?) -> Bool {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        
        if let path = filePath {
            do {
                try data.write(to: path, options: .atomic)
            } catch {
                return false
            }
        } else {
            return false
        }
        return true
    }
    /// Saves a given object as a "CacheEntry" object to disk at the file path specified by "key" parameter.
    ///  - Parameter object: The object to save
    ///  - Parameter key: The path to save at
    /// - Returns: true if the object was saved successfully, or false in case of failure.
    @discardableResult func saveEntry<T: Codable>(object: T?, for key: String) -> Bool {
        let result: Bool
        
        if let data = object as? Data {
            result = saveToDisk(object: CacheEntry(entryObject: data, entryDate: Date().timeIntervalSince1970), filePath: key.getPath(using: mainLocalFolderName))
        } else if let data = object.convertToData() {
            result = saveToDisk(object: CacheEntry(entryObject: data, entryDate: Date().timeIntervalSince1970), filePath: key.getPath(using: mainLocalFolderName))
        } else {
            result = false
        }
        return result
    }
    /// Retrieves the object previously saved at the file path specified by "key" parameter.
    /// - Parameter key: The file path to retrieve from
    /// - Returns: The "CacheEntry" object saved at the given file path or nil if there is no file at path.
    func retrieveEntry(with key: String) -> CacheEntry? {
        if let path = key.getPath(using: mainLocalFolderName)?.path {
            let entry = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? CacheEntry
            return entry
        } else {
            return nil
        }
    }
}
