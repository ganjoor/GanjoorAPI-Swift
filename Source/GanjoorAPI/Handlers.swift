//
//  Categories.swift
//  GanjoorAPI
//
//  Created by Farzad Nazifi on 4/22/17.
//
//

import Foundation
import Kitura
import SwiftyJSON

// MARK: Categories
extension Controller {
    public func categories(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let offset = try request.valuedNumeric(parameter: "offset", source: .parameter) as Int
            _ = connection.query(statement: "select * from categories limit 50 offset \(offset)")
            response.status(.OK).sendutf8(json: JSON(["categories": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
    
    public func category(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let id = try request.valuedNumeric(parameter: "id", source: .parameter) as Int
            _ = connection.query(statement: "select * from categories where id = \(id)")
            response.status(.OK).sendutf8(json: JSON(["category": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
    
    public func topCategories(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        _ = connection.query(statement: "SELECT count(id) as cnt, name from categories GROUP BY name ORDER BY cnt DESC limit 6")
        response.status(.OK).sendutf8(json: JSON(["categories": connection.mappedResults]))
        next()
    }
    
    public func categoriesByPoet(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let id = try request.valued(parameter: "id", source: .parameter) as String
            _ = connection.query(statement: "select * from categories where poetid = \"\(id)\"")
            response.status(.OK).sendutf8(json: JSON(["categories": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
    
    public func categoriesByName(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let name = try request.valued(parameter: "name", source: .parameter) as String
            _ = connection.query(statement: "select * from categories where name = \"\(name)\"")
            response.status(.OK).sendutf8(json: JSON(["categories": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
}

// MARK: Poets
extension Controller {
    public func poets(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let offset = try request.valuedNumeric(parameter: "offset", source: .parameter) as Int
            _ = connection.query(statement: "select * from poets limit 50 offset \(offset)")
            response.status(.OK).sendutf8(json: JSON(["poets": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
    
    public func poet(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let id = try request.valuedNumeric(parameter: "id", source: .parameter) as Int
            _ = connection.query(statement: "select * from poets where id = \(id)")
            response.status(.OK).sendutf8(json: JSON(["poet": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
}

// MARK: Poems
extension Controller {
    public func poemsByCategory(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let id = try request.valuedNumeric(parameter: "id", source: .parameter) as Int
            _ = connection.query(statement: "select * from poems where categoryid = \(id)")
            response.status(.OK).sendutf8(json: JSON(["poems": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
    
    public func poem(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let id = try request.valuedNumeric(parameter: "id", source: .parameter) as Int
            _ = connection.query(statement: "select * from poems where id = \(id)")
            response.status(.OK).sendutf8(json: JSON(["poems": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
}

// MARK: Verses
extension Controller {
    public func verses(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        do {
            let id = try request.valuedNumeric(parameter: "id", source: .parameter) as Int
            _ = connection.query(statement: "select * from verses where poemid = \(id)")
            response.status(.OK).sendutf8(json: JSON(["verses": connection.mappedResults]))
        }catch let err {
            response.status(.noContent).send("\(err)")
        }
        next()
    }
}
