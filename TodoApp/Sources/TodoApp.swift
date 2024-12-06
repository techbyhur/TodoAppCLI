// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation

@main
struct TodoApp: ParsableCommand {
    
    enum Command {
        case add
        case list
        case toggle
        case delete
        case exit
    }
    
    private let todoManager: TodoManager
    private var runApp = true
    
    init() {
        self.todoManager = TodoManager.init()
    }
    
    init(from decoder: any Decoder) throws {
        self.todoManager = TodoManager.init()
    }
    
    mutating func run() throws {
        //take in command line
        print("Welcome to your TODO app!")
        while runApp {
            print("What would you like to do? (add, list, toggle, delete, exit):")
            if let command = readLine() {
                try handleCommand(command)
            } else {
                print("❗Invalid command, please enter a valid command: [add, list, toggle, delete, exit]")
            }
        }
    }
    
    private mutating func handleCommand(_ command: String) throws {
        switch command {
        case "add":
            guard let task = readLine() else {
                print("❗Invalid input. Please enter a task to add.")
                return
            }
            try addTask(task)
        case "list":
            try listTasks()
        case "toggle":
            guard let task = readLine() else {
                print("❗Invalid input. Please enter a valid task to toggle.")
                return
            }
            try toggleTask(task)
        case "delete":
            guard let index = readLine() else {
                print("❗Invalid input. Please enter a task to delete.")
                return
            }
            try deleteTask(index)
        case "exit":
            print("Saving data..")
            todoManager.exit()
            print("👋 Goodbye!")
            runApp = false
        default:
            print("❗Invalid command, please enter a valid command: (add, list, toggle, delete, exit)")
        }
    }
    
    private mutating func addTask(_ task: String) throws {
        todoManager.addTodo(with: task)
    }
    
    private func listTasks() throws {
        todoManager.listTodos()
    }
    
    private func toggleTask(_ index: String) throws {
        //convert index to Int
        if let index = Int(index) {
            todoManager.toggleCompletion(forTodoAtIndex: Int(index))
        } else {
            print("Invalid input. Please enter a valid index.")
        }
    }
    
    private func deleteTask(_ index: String) throws {
        //convert index to Int
        if let index = Int(index) {
            todoManager.deleteTodo(atIndex: Int(index))
        } else {
            print("Invalid input. Please enter a valid index.")
        }
        
    }
}
