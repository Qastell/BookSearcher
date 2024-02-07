//
//  Storage.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import CoreData

class Storage {
    private let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext

    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        var description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions.append(description)
        container.viewContext.mergePolicy = NSMergePolicy.overwrite
        container.loadPersistentStores { _, error in
            if let error {
                mark(error)
            }
        }
        return container
    }()

    init() {
        mainContext = persistentContainer.viewContext
        backgroundContext = persistentContainer.newBackgroundContext()
    }

    func saveContextIfChanged() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
                saveMainContext()
            } catch {
                mark(error)
            }
        }
    }

    private func saveMainContext() {
        self.mainContext.performAndWait {
            do {
                try self.mainContext.save()
            } catch {
                mark(error)
            }
        }
    }
}
