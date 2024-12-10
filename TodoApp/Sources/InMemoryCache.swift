//
//  InMemoryCache.swift
//  TodoApp
//
//  Created by Ila Hur on 11/29/24.
//


// `InMemoryCache`: : Keeps todos in an array or similar structure during the session. 
// This won't retain todos across different app launches, 
// but serves as a quick in-session cache.
final class InMemoryCache: Cache {
    
    private var todoList: [Todo]
    
    init(savedList list: [Todo]?) {
        self.todoList = list ?? []
    }
    
    func save(todos: [Todo]) -> Bool {
        todoList = todos
        return true
    }
    
    func load() -> [Todo]? {
        return todoList
    }
}
