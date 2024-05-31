//
//  CacheEntry.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation

/// CacheEntry is a class used as a container for cached data
class CacheEntry: NSObject, NSCoding {
   // MARK: - Properties
    private var entryObject: Data?
    private var entryDate: TimeInterval?
    private static let entryObjectKey = "entryObject"
    private static let entryDateKey = "entryDate"
    // MARK: - Initializer(s)
    required public init?(coder decoder: NSCoder) {
        self.entryObject = decoder.decodeObject(forKey: CacheEntry.entryObjectKey) as? Data
        self.entryDate = decoder.decodeObject(forKey: CacheEntry.entryDateKey) as? TimeInterval
    }
    init(entryObject: Data, entryDate: TimeInterval) {
        self.entryObject = entryObject
        self.entryDate = entryDate
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(entryObject, forKey: CacheEntry.entryObjectKey)
        aCoder.encode(entryDate, forKey: CacheEntry.entryDateKey)
    }
    // MARK: - Method(s)
    
    /// Get actual cached object after decoding it.
    /// - Returns: the actual cached object
    func getEntryObject<T: Codable>() -> T? {
        if let data: Data = self.entryObject {
            let decoder = JSONDecoder()
            let value = try? decoder.decode(T.self, from: data)
            return value
        } else {
            return self.entryObject as? T
        }
    }
    /// Get entry date for cached object.
    /// - Returns: the entry date of cached object
    func getEntryDate() -> TimeInterval? {
       return self.entryDate
    }
}
