//
//  RequestExtension.swift
//  GanjoorAPI
//
//  Created by Farzad Nazifi on 4/22/17.
//
//

import Foundation
import KituraRequest
import SwiftyJSON
import Kitura
import Axis
import LoggerAPI

// MARK: MYSQL
extension MySQL {
    var mappedResults: [[String: String?]] {
        let results = self.storeResults()
        var resultArray = [[String: String?]]()
        while let row = results?.next() {
            resultArray.append(row)
        }
        return resultArray
    }
}

// MARK: Kitura
extension RouterRequest {
    enum RequestError: LocalizedError {
        var errorDescription: String? {
            switch self {
            case .missing(let string):
                return "parameter \(string) is missing"
            case .type(let string, let string2):
                return "parameter \(string) is not \(string2)"
            }
        }
        case missing(String)
        case type(String, String)
    }
    
    func valuedNumeric<T: NumericType>(parameter: String) throws -> T {
        let genericType = "\(T.self)".split(separator: ".").first!
        
        if let parameterIsThere = self.queryParameters[parameter] {
            switch genericType {
            case "Double":
                if let converted = Double(parameterIsThere) {
                    return converted as! T
                }
                throw RequestError.type(parameter, genericType)
            case "String":
                return "\(parameterIsThere)" as! T
            case "Int":
                if let converted = Int(parameterIsThere) {
                    return converted as! T
                }
                throw RequestError.type(parameter, genericType)
            default:
                return "" as! T
            }
        }else{
            throw RequestError.missing("\(parameter)")
        }
    }
    
    func valued<T>(parameter: String) throws -> T {
        let genericType = "\(T.self)".split(separator: ".").first!
        
        if let parameterIsThere = self.queryParameters[parameter] {
            switch genericType {
            case "String":
                return "\(parameterIsThere)" as! T
            case "Bool":
                return Bool(parameterIsThere) as! T
            default:
                return "" as! T
            }
        }else{
            throw RequestError.missing("\(parameter)")
        }
    }
}

protocol NumericType {
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static func %(lhs: Self, rhs: Self) -> Self
    init(_ v: Int)
}

extension Double : NumericType { }
extension Float  : NumericType { }
extension Int    : NumericType { }
extension Int8   : NumericType { }
extension Int16  : NumericType { }
extension Int32  : NumericType { }
extension Int64  : NumericType { }
extension UInt   : NumericType { }
extension UInt8  : NumericType { }
extension UInt16 : NumericType { }
extension UInt32 : NumericType { }
extension UInt64 : NumericType { }

extension RouterResponse {

    @discardableResult
    public func sendutf8(json: JSON) -> RouterResponse {
        do {
            let jsonData = try json.rawData(options:.prettyPrinted)
            headers.setType("json", charset: "utf-8")
            send(data: jsonData)
        } catch {
            Log.warning("Failed to convert JSON for sending: \(error.localizedDescription)")
        }
        
        return self
    }
}
