//
//  BookObject.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import CoreData

@objc(BookObject)
class BookObject: NSManagedObject {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<BookObject> {
        return NSFetchRequest<BookObject>(entityName: "BookObject")
    }

    @NSManaged var id: String
    @NSManaged var title: String?
    @NSManaged var authors: String?
    @NSManaged var imagePath: String?
    @NSManaged var year: String?
    @NSManaged var refreshingDate: Date
}
