//
//  PostListItemDAO.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import CoreData

internal struct PostListItemDAO: DAO {

    internal typealias LowLevelModel = ListItem
    internal typealias HighLevelModel = PostListItem
    internal typealias Context = NSManagedObjectContext

    internal func translate(
        _ model: ListItem,
        context: NSManagedObjectContext?
    ) throws -> PostListItem {
        PostListItem(id: model.id, title: model.title ?? "", body: model.body ?? "", userId: model.userId)
    }
    
    internal func translate(
        _ model: PostListItem,
        context: NSManagedObjectContext?
    ) throws -> ListItem {
        guard let context else { throw NSError() }
        let item = ListItem(context: context)
        item.id = model.id
        item.userId = model.userId
        item.title = model.title
        item.body = model.body
        return item
    }
}
