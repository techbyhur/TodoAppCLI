//
//  JSONFileManagerCache.swift
//  TodoApp
//
//  Created by Ila Hur on 11/29/24.
//

import Foundation

// `FileSystemCache`: This implementation should utilize the file system
// to persist and retrieve the list of todos.
// Utilize Swift's `FileManager` to handle file operations.

//Note: some of the FileManager setup code was created by refering to https://www.swiftyplace.com/blog/file-manager-in-swift-reading-writing-and-deleting-files-and-directories
final class JSONFileManagerCache: Cache {
    
    private let fileManager: FileManager = FileManager.default
    private let content: Data
    private let destintationUrl: URL
    
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
    
    /*
     save function to write todo data to the connected file
     */
    func save(todos: [Todo]) -> Bool {
        //convert the todo list to a JSON array and write it to the file
        guard let updatedContent = encodeData(from: todos)?.data(using: .utf8) else {
            print("Failed to convert content to JSON. Please try again later.")
            return false
        }
        do {
            try updatedContent.write(to: destintationUrl)
            print("File updated successfully")
            return true
        } catch {
            print("Failed to update file: \(error.localizedDescription)")
            return false
        }
    }
    
    /*
     load function to load tasks from connected file
     */
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
    
    /*
     encodeData function to convert todo list to a JSON object, then to a String object in order to write it to
     connected text file
     */
    private func encodeData(from list:[Todo]) -> String? {
        do {
            let data = try JSONEncoder().encode(list)
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            print("Error reading file: \(error)")
        }
        return "[]"
    }
}
