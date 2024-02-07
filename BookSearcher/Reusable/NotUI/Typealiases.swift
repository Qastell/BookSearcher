//
//  Typealiases.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

typealias Closure = () -> Void
typealias ResultClosure<T> = DataClosure<Result<T, Error>>
typealias DataClosure<T> = (T) -> Void

let mainQueue = DispatchQueue.main
