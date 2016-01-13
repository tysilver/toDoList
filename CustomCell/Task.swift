//
//  Task.swift
//  CustomCell
//
//  Created by Tyler Silverman on 11/20/15.
//  Copyright © 2015 Tyler Silverman. All rights reserved.
//

import Foundation
class Task: NSObject, NSCoding{
    static var key: String = "myTasks"
    static var schema: String = "theListOfTasks"
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
    static func all() -> [Task] {
        var tasks = [Task]()
        let path = Database.dataFilePath("theListOfTasks")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                tasks = unarchiver.decodeObjectForKey(Task.key) as! [Task]
                unarchiver.finishDecoding()
            }
        }
        return tasks
    }
    func save() {
        var tasksFromStorage = Task.all()
        print(tasksFromStorage)
        var exists = false
        for var i = 0; i < tasksFromStorage.count; ++i {
            if tasksFromStorage[i].createdAt == self.createdAt {
                tasksFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            tasksFromStorage.append(self)
        }
        Database.save(tasksFromStorage, toSchema: Task.schema, forKey: Task.key)
    }
    
    func destroy() {
        var tasksFromStorage = Task.all()
        for var i = 0; i < tasksFromStorage.count; ++i {
            if tasksFromStorage[i].createdAt == self.createdAt {
                tasksFromStorage.removeAtIndex(i)
            }
        }
        Database.save(tasksFromStorage, toSchema: Task.schema, forKey: Task.key)
    }
}