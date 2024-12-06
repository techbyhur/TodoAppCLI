//
//  Todo.swift
//  TodoApp
//
//  Created by Ila Hur on 11/29/24.
//

import Foundation

struct Todo: Codable, CustomStringConvertible {
    var description: String
    let id: UUID
    let title: String
    var isCompleted: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case isCompleted = "completed"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        isCompleted = try values.decode(Bool.self, forKey: .isCompleted)
        description = "\(id) - \((isCompleted ? "✅" : "❌")) \((title))"
    }
    
    init(id: UUID, title: String) {
        self.description = "\(id) - ❌ \((title))"
        self.id = id
        self.title = title
        self.isCompleted = false
    }
}
