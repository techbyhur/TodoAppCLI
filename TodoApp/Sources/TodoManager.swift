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
    
    private var cache: Cache
    
    init(cache: Cache) {
        self.cache = cache
    }
    
    /*
     listTodos function to list tasks
     */
    func listTodos() {
        print("📝 List of Tasks:")
        //print out todo tasks
        var index: Int = 1
        let listOfTodos = cache.load() ?? []
        listOfTodos.forEach {
            print( "\(index). \(($0.isCompleted ? "✅" : "❌")) \(($0.title))" )
            index += 1
        }
    }
    
    /*
     addTodo function to add task to local list and save it to the local cache
     */
    func addTodo(with title: String) {
        var listOfTodos = self.cache.load() ?? []
        print("📌 Adding new task: \(title)")
        //add task to todo list
        let newTask = Todo(id: UUID(), title: title)
        listOfTodos.append(newTask)
        let didAddSuccesfully = self.cache.save(todos: listOfTodos)
        if (didAddSuccesfully) {
            print("-- Updated list --")
            listTodos()
        } else {
            print("❗ Looks like something went wrong when trying to save the task. Please try again.")
        }
    }
    
    /*
     toggleCompletion function to toggle the completion status of tasks within the session and save it to the local cache
     */
    func toggleCompletion(forTodoAtIndex index: Int) {
        var listOfTodos = self.cache.load() ?? []
        if (index > listOfTodos.count || index <= 0) {
            print("❗Invalid task. Please enter a valid task you would like to mark as completed.")
            return
        }
        print("🔄 Task completion status updating...")
        listOfTodos[index-1].isCompleted.toggle()
        let didToggleSuccessfully = self.cache.save(todos: listOfTodos)
        if (didToggleSuccessfully) {
            print("🌟 Status updated. You've completed a task! Keep up the great work 🤩")
        } else {
            print("❗ Looks like something went wrong when trying to save the task. Please try again.")
        }
    }
    
    /*
     deleteTodo function to delete task and save it to the local cache
     */
    func deleteTodo(atIndex index: Int) {
        var listOfTodos = self.cache.load() ?? []
        if (index > listOfTodos.count || index <= 0) {
            print("❗Invalid task. Please enter a valid task to delete.")
            return
        }
        print("🗑️  Deleting task at index: \(index)")
        listOfTodos.remove(at: index-1)
        let didSaveSuccessfully = self.cache.save(todos: listOfTodos)
        if (didSaveSuccessfully) {
            print("🚀 Updated task list")
            listTodos()
        } else {
            print("❗ Looks like something went wrong when trying to delete the task. Please try again.")
        }
    }
    
    /*
     exit function ensure that list of tasks is saved to the connected file
     */
    func exit(cache: Cache) {
        //no-op
        let listOfTodos: [Todo] = self.cache.load() ?? []
        let didSaveSuccessfully = cache.save(todos: listOfTodos)
        if (!didSaveSuccessfully) {
            print("❗ Looks like something went wrong when trying to save task list. Please try again later.")
        }
    }
}
