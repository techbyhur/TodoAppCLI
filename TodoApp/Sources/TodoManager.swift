//
//  TodoManager.swift
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
    
    /*
     listTodos function to list tasks
     */
    func listTodos() {
        print("📝 List of Tasks:")
        //print out todo tasks
        var index: Int = 1
        listOfTodos.forEach {
            print( "\(index). \(($0.isCompleted ? "✅" : "❌")) \(($0.title))" )
            index += 1
        }
    }
    
    /*
     addTodo function to add task to local list and save it to the local cache
     */
    func addTodo(with title: String) {
        print("📌 Adding new task: \(title)")
        //add task to todo list
        let newTask = Todo(id: UUID(), title: title)
        listOfTodos.append(newTask)
        self.inMemoryCacheManager.save(todos: listOfTodos)
        
        print("-- Updated list --")
        listTodos()
    }
    
    /*
     toggleCompletion function to toggle the completion status of tasks within the session and save it to the local cache
     */
    func toggleCompletion(forTodoAtIndex index: Int) {
        print("🔄 Task completion status updating...")
        listOfTodos[index-1].isCompleted.toggle()
        self.inMemoryCacheManager.save(todos: listOfTodos)
        print("🌟 Status updated. You've completed a task! Keep up the great work 🤩")
    }
    
    /*
     deleteTodo function to delete task and save it to the local cache
     */
    func deleteTodo(atIndex index: Int) {
        print("🗑️ Deleting task at index: \(index)")
        listOfTodos.remove(at: index-1)
        self.inMemoryCacheManager.save(todos: listOfTodos)
        print("🚀 Updated task list")
        listTodos()
    }
    
    /*
     exit function ensure that list of tasks is saved to the connected file
     */
    func exit() {
        self.inMemoryCacheManager.saveAll(todos: listOfTodos)
    }
}
