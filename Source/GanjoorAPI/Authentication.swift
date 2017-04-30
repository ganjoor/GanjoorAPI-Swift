//
//  Credintionals.swift
//  GanjoorAPI
//
//  Created by Farzad Nazifi on 4/26/17.
//
//

import Foundation
import CredentialsHTTP
import Credentials
import KituraNet
import JWT
import CryptoSwift
import Cryptor
import Kitura

public class JWTCredentials: CredentialsPluginProtocol {
    
    let secret: String
    
    public enum accessLevel: String {
        case developer = "developer"
        case admin = "admin"
    }
    
    public var name: String {
        return "JWTCredentials"
    }
    
    public var redirecting: Bool {
        return false
    }
    
    public var usersCache: NSCache<NSString, BaseCacheElement>?
    
    public init(secret: String) {
        self.secret = secret
    }
    
    public func authenticate(request: RouterRequest, response: RouterResponse,
                             options: [String:Any], onSuccess: @escaping (UserProfile) -> Void,
                             onFailure: @escaping (HTTPStatusCode?, [String:String]?) -> Void,
                             onPass: @escaping (HTTPStatusCode?, [String:String]?) -> Void,
                             inProgress: @escaping () -> Void) {
        do {
            let tokenValue = try request.valued(parameter: "Authorization", source: .header) as String
            if let token = tokenValue.split(separator: " ").last {
                let claims: ClaimSet = try JWT.decode(token, algorithm: .hs256(secret.data(using: .utf8)!))
                let claimValue = claims["accessLevel"] as? String
                if let level = accessLevel(rawValue: claimValue!) {
                    let profile = UserProfile(id: token, displayName: level.rawValue, provider: "JWT")
                    onSuccess(profile)
                }else{
                    onFailure(.unauthorized, nil)
                }}
        } catch {
            onFailure(.unauthorized, nil)
        }
    }
}

extension JWTCredentials {
    func generateToken(accessLevel: accessLevel) -> String {
        var claims = ClaimSet()
        claims["accessLevel"] = accessLevel.rawValue
        return JWT.encode(claims: claims, algorithm: .hs256(secret.data(using: .utf8)!))
    }
}
