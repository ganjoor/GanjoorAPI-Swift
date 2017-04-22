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
import CredentialsHTTP
import Credentials

public class Controller {
    
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
        print(connected ? "yes" : "no")
        router = Router()
    
        router.all("categories", handler: categories)
        router.all("categories/", handler: category)
        router.all("topCategories", handler: topCategories)
        router.all("categories/byName/", handler: categoriesByName)
        
        router.all("poets", handler: poets)
        router.all("poets/", handler: poet)

        router.all("poems/byCategory/", handler: poemsByCategory)
        router.all("poems/", handler: poem)
        
        router.all("verses/byPoem/", handler: verses)
    }
}
