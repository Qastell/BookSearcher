//
//  Task+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

extension Task where Failure == Error {
    static func delayed(byTimeInterval delayInterval: TimeInterval,
                        priority: TaskPriority? = nil,
                        operation: @escaping @Sendable () async throws -> Success) -> Task {
        Task(priority: priority) {
            let delay = UInt64(delayInterval * Double(NSEC_PER_SEC))
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            return try await operation()
        }
    }
}
