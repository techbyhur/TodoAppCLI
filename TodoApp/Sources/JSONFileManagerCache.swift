//
//  File.swift
//  TodoApp
//
//  Created by Ila Hur on 11/29/24.
//

import Foundation

// `FileSystemCache`: This implementation should utilize the file system
// to persist and retrieve the list of todos.
// Utilize Swift's `FileManager` to handle file operations.
final class JSONFileManagerCache: Cache {
    
    let fileManager: FileManager = FileManager.default
    let content: Data
    let destintationUrl: URL
    
    init() {
        let documentsURL = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        self.destintationUrl = documentsURL.appendingPathComponent("/tasks.txt")
        if fileManager.fileExists(atPath: self.destintationUrl.path) {
            self.content = fileManager.contents(atPath: self.destintationUrl.path) ?? "[]".data(using: .utf8)!
        } else {
            self.content = "[]".data(using: .utf8)!
            fileManager.createFile(atPath: destintationUrl.path, contents: self.content, attributes: nil)
            print("File not found. File created.")
        }
    }
    
    func save(todos: [Todo]) {
        //convert the todo list to a JSON array and write it to the file
        guard let updatedContent = toString(from: todos)?.data(using: .utf8) else {
            print("Failed to convert content to JSON")
            return
        }
        do {
            try updatedContent.write(to: destintationUrl)
            print("File updated successfully")
        } catch {
            print("Failed to update file: \(error.localizedDescription)")
        }
    }
    
    func load() -> [Todo]? {
        //convert file data to Todo list
        do {
            let data = try Data(contentsOf: destintationUrl)
            return try JSONDecoder().decode([Todo].self, from: data)
        } catch {
            print("Error reading file: \(error)")
        }
        return []
    }
    
    private func toString(from list:[Todo]) -> String? {
        do {
            let data = try JSONEncoder().encode(list)
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            print("Error reading file: \(error)")
        }
        return "[]"
    }
}
