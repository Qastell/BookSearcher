//
//  GlobalMethods.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

func mark(_ error: Error,
          fileName: String = #file,
          lineNumber: Int = #line,
          functionName: String = #function) {
    let traceString = "\(fileName.components(separatedBy: "/").last!) -> \(functionName) -> \(error) (line: \(lineNumber))"
    print(traceString)
}

func mark(_ message: String,
          fileName: String = #file,
          lineNumber: Int = #line,
          functionName: String = #function) {
    let traceString = "\(fileName.components(separatedBy: "/").last!) -> \(functionName) -> \(message) (line: \(lineNumber))"
    print(traceString)
}
