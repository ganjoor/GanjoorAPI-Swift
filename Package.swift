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

import PackageDescription

#if os(OSX)
let package = Package(
    name: "GanjoorAPI",
    targets: [
        Target(name: "GanjoorAPI", dependencies: [])
    ],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-mysqlclient.git", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/Swift-cfenv.git", majorVersion: 2),
        .Package(url: "https://github.com/IBM-Swift/Kitura-Request.git", majorVersion: 0, minor: 8),
        .Package(url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", majorVersion: 1),
        .Package(url: "https://github.com/Zewo/Axis.git", majorVersion: 0, minor: 14),
        .Package(url: "https://github.com/kylef/JSONWebToken.swift.git", majorVersion: 2, minor: 1)
    ],
    exclude: ["Makefile", "Package-Builder"])
#else
let package = Package(
    name: "GanjoorAPI",
    targets: [
        Target(name: "GanjoorAPI", dependencies: [])
    ],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-mysqlclient-Linux.git", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/Swift-cfenv.git", majorVersion: 2),
        .Package(url: "https://github.com/IBM-Swift/Kitura-Request.git", majorVersion: 0, minor: 8),
        .Package(url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", majorVersion: 1),
        .Package(url: "https://github.com/Zewo/Axis.git", majorVersion: 0, minor: 14),
        .Package(url: "https://github.com/kylef/JSONWebToken.swift.git", majorVersion: 2, minor: 1)
    ],
    exclude: ["Makefile", "Package-Builder"])
#endif

