//
//  Finished.swift
//  CustomCell
//
//  Created by Tyler Silverman on 11/20/15.
//  Copyright © 2015 Tyler Silverman. All rights reserved.
//

import Foundation

class Finished: NSObject, NSCoding {
    static var key: String = "myFinishedTasks"
    static var schema: String = "theListOfFinishedTasks"
    var objective: String
    var createdAt: NSDate
    init (obj: String) {
        objective = obj
        createdAt = NSDate()
    }
    
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
    }
    // used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        objective = aDecoder.decodeObjectForKey("objective") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    // MARK: - Queries
    static func all() -> [Finished] {
        var finisheds = [Finished]()
        let path = Database.dataFilePath("theListOfFinishedTasks")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                finisheds = unarchiver.decodeObjectForKey(Finished.key) as! [Finished]
                unarchiver.finishDecoding()
            }
        }
        return finisheds
    }
    func save() {
        var finishedsFromStorage = Finished.all()
        print(finishedsFromStorage)
        var exists = false
        for var i = 0; i < finishedsFromStorage.count; ++i {
            if finishedsFromStorage[i].createdAt == self.createdAt {
                finishedsFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            finishedsFromStorage.append(self)
        }
        Database.save(finishedsFromStorage, toSchema: Finished.schema, forKey: Finished.key)
    }
    
    func destroy() {
        var finishedsFromStorage = Finished.all()
        for var i = 0; i < finishedsFromStorage.count; ++i {
            if finishedsFromStorage[i].createdAt == self.createdAt {
                finishedsFromStorage.removeAtIndex(i)
            }
        }
        Database.save(finishedsFromStorage, toSchema: Finished.schema, forKey: Finished.key)
    }
}