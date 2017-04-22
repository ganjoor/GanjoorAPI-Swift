/**
 * Copyright IBM Corporation 2016
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
import LoggerAPI
import HeliumLogger
import CloudFoundryEnv
import KituraNet
import SSLService
import SwiftyJSON

let myMacCertPath = "/Users/farzad/Desktop/certs/cert.pfx"
let myCertPath = "/tmp/Creds/Self-Signed/cert.pem"
let myKeyPath = "/tmp/Creds/Self-Signed/key.pem"
HeliumLogger.use(.debug)

do {
    let controller = try Controller()

    //    Kitura.addHTTPServer(onPort: 443, with: controller.router, withSSL: SSLConfig(withChainFilePath: myMacCertPath, withPassword: " ", usingSelfSignedCerts: false, cipherSuite: nil))
    Kitura.addHTTPServer(onPort: controller.port, with: controller.router)
    Kitura.run()
    
} catch let error {
    Log.error(error.localizedDescription)
    Log.error("Oops... something went wrong. Server did not start!")
}
