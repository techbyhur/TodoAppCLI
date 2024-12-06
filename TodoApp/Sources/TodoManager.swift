//
//  File.swift
//  TodoApp
//
//  Created by Ila Hur on 11/29/24.
//

import Foundation

// The `TodosManager` class should have:
// * A function `func listTodos()` to display all todos.
// * A function named `func addTodo(with title: String)` to insert a new todo.
// * A function named `func toggleCompletion(forTodoAtIndex index: Int)`
//   to alter the completion status of a specific todo using its index.
// * A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.
final class TodoManager {
    
    private let inMemoryCacheManager: InMemoryCache = InMemoryCache.init()
    private var listOfTodos: [Todo]
    
    init() {
        listOfTodos = self.inMemoryCacheManager.load() ?? []
    }

    func listTodos() {
        print("📝 List of Tasks:")
        //print out todo tasks
        var index: Int = 1
        listOfTodos.forEach {
            print( "\(index). \(($0.isCompleted ? "✅" : "❌")) \(($0.title))" )
            index += 1
        }
    }

    func addTodo(with title: String) {
        print("📌 Adding new task: \(title)")
        //add task to todo list
        let newTask = Todo(id: UUID(), title: title)
        listOfTodos.append(newTask)
        self.inMemoryCacheManager.save(todos: listOfTodos)
        
        print("-- Updated list --")
        listTodos()
    }

    func toggleCompletion(forTodoAtIndex index: Int) {
        print("🔄 Task completion status updating...")
        listOfTodos[index-1].isCompleted.toggle()
        self.inMemoryCacheManager.save(todos: listOfTodos)
        print("🌟 Status updated. You've completed a task! Keep up the great work 🤩")
    }

    func deleteTodo(atIndex index: Int) {
        print("🗑️ Deleting task at index: \(index)")
        listOfTodos.remove(at: index-1)
        self.inMemoryCacheManager.save(todos: listOfTodos)
        print("🚀 Updated task list")
        listTodos()
    }
    
    func exit() {
        self.inMemoryCacheManager.saveAll(todos: listOfTodos)
    }
}
