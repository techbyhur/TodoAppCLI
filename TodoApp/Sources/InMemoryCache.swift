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
    
    private let fileManger: JSONFileManagerCache
    private var todoList: [Todo]
    
    init() {
        self.fileManger = .init()
        todoList = self.fileManger.load() ?? []
    }
    
    func save(todos: [Todo]) {
        todoList = todos
    }
    
    func load() -> [Todo]? {
        return todoList
    }
    
    /*
     saveAll function to ensure that all the data from within the session is saved within the file manager
     
     This is designed this way in order to reduce the number of times data is written to the connected file, and improve efficiency of
     application.
     */
    func saveAll(todos: [Todo]) {
        self.fileManger.save(todos: todos)
    }
}
