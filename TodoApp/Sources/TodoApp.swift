// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation

@main
struct TodoApp: ParsableCommand {
    
    //accepted commands for application
    enum Command {
        case add
        case list
        case toggle
        case delete
        case exit
    }
    
    //local TodoManager object variable
    private let todoManager: TodoManager
    
    //variable to ensure application exits
    private var runApp = true
    
    init() {
        self.todoManager = TodoManager.init(cache: InMemoryCache(savedList: JSONFileManagerCache().load()))
    }
    
    init(from decoder: any Decoder) throws {
        self.todoManager = TodoManager.init(cache: InMemoryCache(savedList: JSONFileManagerCache().load()))
    }
    
    public mutating func run() throws {
        //take in command line
        print("Welcome to your TODO app!")
        while runApp {
            print("What would you like to do? (add, list, toggle, delete, exit):")
            if let command = readLine() {
                try handleCommand(command)
            } else {
                print("❗ Invalid command, please enter a valid command: [add, list, toggle, delete, exit]")
            }
        }
    }
    
    /*
        handleCommand function that manages the command input accordingly and executes associate method within the TodoManager
     */
    private mutating func handleCommand(_ command: String) throws {
        switch command {
        case "add":
            print("Please enter task:")
            guard let task = readLine() else {
                print("❗ Invalid input. Please enter a task to add.")
                return
            }
            try addTask(task)
        case "list":
            try listTasks()
        case "toggle":
            print("Please the index of the task you wish to toggle:")
            guard let task = readLine() else {
                print("❗ Invalid input. Please enter a valid task to toggle.")
                return
            }
            try toggleTask(task)
        case "delete":
            print("Please the index of the task you wish to delete:")
            guard let index = readLine() else {
                print("❗ Invalid input. Please enter a task to delete.")
                return
            }
            try deleteTask(index)
        case "exit":
            exitApp()
        default:
            print("❗ Invalid command, please enter a valid command: (add, list, toggle, delete, exit)")
        }
    }
    
    /*
     addTask function to request Todo Manager to add task
     */
    private mutating func addTask(_ task: String) throws {
        todoManager.addTodo(with: task)
    }
    
    /*
     listTasks function to request Todo Manager to list tasks
     */
    private func listTasks() throws {
        todoManager.listTodos()
    }
    
    /*
     toggleTask function to request Todo Manager to toggle task completion status
     */
    private func toggleTask(_ index: String) throws {
        //convert index to Int
        if let index = Int(index) {
            todoManager.toggleCompletion(forTodoAtIndex: Int(index))
        } else {
            print("❗ Invalid input. Please enter a valid index.")
        }
    }
    
    /*
     deleteTask function to request Todo Manager to delete task
     */
    private func deleteTask(_ index: String) throws {
        //convert index to Int
        if let index = Int(index) {
            todoManager.deleteTodo(atIndex: Int(index))
        } else {
            print("❗ Invalid input. Please enter a valid index.")
        }
    }
    
    /*
     exitApp function to save data to file manager and exit the application
     */
    private mutating func exitApp() {
        print("Saving data..")
        self.todoManager.exit(cache: JSONFileManagerCache())
        print("👋 Goodbye!")
        runApp = false
   }
}
