# Ganjoor API - Swift
Ganjoor.net REST API done in swift

## Local Development -
[Database](https://github.com/ganjoor/ganjoor-db) is needed for local development.

### MacOS
You need latest version of Xcode and Install mysql using [Homebrew](https://brew.sh)
```
$ brew install mysql
```
make sure you are in project directory and start a build
```
$ swift build
```
Run
```
$ ./.build/debug/GanjoorAPI
```
### Generate Xcode project
If you like to build/edit project in xcode you can generate xcode project by using this command
```
$ swift package generate-xcodeproj
```

### Linux
Install [swift 3.1](https://swift.org/getting-started/) by following getstarted and after install these packages
```
$ apt -y install clang libicu-dev libcurl4-openssl-dev libssl-dev libmysqlclient-dev
```
make sure you are in project directory and start a build
```
$ swift build
```
Run
```
$ ./.build/debug/GanjoorAPI
```

## Development Docker

If you just want to run a docker container locally to host the API and the Database for you:
``` bash
$ docker-compose up
```

This might take a while, wait until you see "GanjoorAPI is Up and Running" Which means everything went as expected.
open [http://localhost:7080/](http://localhost:7080/), if you see kitura start page. you are good to go.

This software is released under the [MIT License](LICENSE).
