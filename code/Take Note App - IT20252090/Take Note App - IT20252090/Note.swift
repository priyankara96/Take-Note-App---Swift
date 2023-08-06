//
//  Note.swift
//  Take Note App - IT20252090
//
//  Created by Priyankara on 2023-04-16.
//

import CoreData

@objc(Note)
class Note: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}
