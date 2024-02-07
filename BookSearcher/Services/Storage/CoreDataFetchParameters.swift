//
//  CoreDataFetchParameters.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import CoreData

struct CoreDataFetchParameters {
    let predicate: NSPredicate?
    let sortDescriptors: [NSSortDescriptor]?

    init(predicate: NSPredicate? = nil,
         sortDescriptors: [NSSortDescriptor]? = nil) {
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
    }
}
