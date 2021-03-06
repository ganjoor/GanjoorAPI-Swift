/**
 * Copyright IBM Corporation 2016,2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import Kitura
import SwiftyJSON
import LoggerAPI
import CloudFoundryEnv
import KituraRequest
import Dispatch
import JWT
import Credentials

public class Controller {
    
    public enum initError: Swift.Error {
        case databaseConnectionFail
    }
    
    let router: Router
    let appEnv: AppEnv
    var jsonEndpointEnabled: Bool = true
    var jsonEndpointDelay: UInt32 = 0
    var port: Int {
        get { return 7080 }
    }
    
    var url: String {
        get { return appEnv.url }
    }
    
    let connection = MySQL()
    
    init() throws {
        appEnv = try CloudFoundryEnv.getAppEnv()
        let connected = connection.connect(host: "mysql", user: "root", password: "root", db: "ganjoor")
        if connected {
            _ = connection.query(statement: "SET CHARACTER SET utf8")
            Log.debug("GanjoorAPI is connected to database")
        }else{
            throw initError.databaseConnectionFail
        }
        
        router = Router()
        
        let credentials = Credentials()
        let jwt = JWTCredentials(secret: "secret")
        credentials.register(plugin: jwt)
        
        // comment the line bellow if you don't want to generate new token on server start
        Log.info("new token with accessLevel developer: \(jwt.generateToken(accessLevel: .developer))")
        
        router.get("", middleware: credentials)
        
        router.get("categories", handler: categories)
        router.get("categories/", handler: category)
        router.get("topCategories", handler: topCategories)
        router.get("categories/byPoet/", handler: categoriesByPoet)
        router.get("categories/byName/", handler: categoriesByName)
        
        router.get("poets", handler: poets)
        router.get("poets/", handler: poet)
        
        router.get("poems/byCategory/", handler: poemsByCategory)
        router.get("poems/", handler: poem)
        
        router.get("verses/byPoem/", handler: verses)
    }
}

