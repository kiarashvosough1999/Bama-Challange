//
//  PostListItem.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Foundation

public struct PostListItem: Codable, Equatable {

    public var id: Int32
    public var title: String
    public var body: String
    public var userId: Int32

    public init(id: Int32, title: String, body: String, userId: Int32) {
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
    }

    enum CodingKeys: CodingKey {
        case id
        case title
        case body
        case userId
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.userId = try container.decode(Int32.self, forKey: .userId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.body, forKey: .body)
        try container.encode(self.userId, forKey: .userId)
    }
}
