//
//  Cache.swift
//  TodoApp
//
//  Created by Ila Hur on 11/29/24.
//

import Foundation

// Create the `Cache` protocol that defines the following method signatures:
//  `func save(todos: [Todo])`: Persists the given todos.
//  `func load() -> [Todo]?`: Retrieves and returns the saved todos, or nil if none exist.
protocol Cache {
    func save(todos: [Todo])
    func load() -> [Todo]?
}
