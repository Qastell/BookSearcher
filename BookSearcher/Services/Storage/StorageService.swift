//
//  StorageService.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import CoreData

protocol StorageService: AnyObject {
    associatedtype Object

    func createObject(configurationHandler: @escaping DataClosure<Object>) -> Object?
    func fetchAll(fetchConfiguration: CoreDataFetchParameters?,
                  completion: @escaping DataClosure<[Object]?>)
}

class StorageServiceImplementation<Object: NSManagedObject>: Storage {}

// MARK: - StorageService

extension StorageServiceImplementation: StorageService {
    func createObject(configurationHandler: @escaping DataClosure<Object>) -> Object? {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: Object.classDescription,
                                                               into: backgroundContext) as? Object else {
            return nil
        }

        write()
        configurationHandler(object)
        return object
    }

    func fetchAll(fetchConfiguration: CoreDataFetchParameters?,
                  completion: @escaping DataClosure<[Object]?>) {
        perform { [weak self] in
            guard let self else { return }

            do {
                let request = NSFetchRequest<Object>(entityName: Object.classDescription)
                request.predicate = fetchConfiguration?.predicate
                request.sortDescriptors = fetchConfiguration?.sortDescriptors
                let result = try backgroundContext.fetch(request)
                completion(result.nilIfEmpty)
            } catch {
                mark(error)
                completion(nil)
            }
        }
    }
}

// MARK: - Private methods

private extension StorageServiceImplementation {
    func write() {
        perform { [weak self] in
            self?.saveContextIfChanged()
        }
    }

    func perform(_ block: @escaping Closure) {
        backgroundContext.perform {
            block()
        }
    }
}


