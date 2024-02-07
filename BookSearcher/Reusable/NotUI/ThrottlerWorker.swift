//
//  ThrottlerWorker.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

final class ThrottlerWorker<T: Sendable> {
    private var task: Task<T, Error>?
}

extension ThrottlerWorker {
    func cancel() {
        task?.cancel()
    }
    
    @discardableResult
    func throttle(delayInterval: TimeInterval,
                  operation: @escaping @Sendable () async throws -> T) -> Task<T, Error>? {
        task?.cancel()
        task = Task.delayed(byTimeInterval: delayInterval) { [weak self] in
            if let task = self?.task, !task.isCancelled {
                return try await operation()
            } else {
                throw BSError.taskTrottleCancelled
            }
        }
        return task
    }
}
