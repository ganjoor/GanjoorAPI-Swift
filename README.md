# Ganjoor API - Swift
Ganjoor.net REST API done in swift

## Local Development
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

### Ubuntu 16.04 LTS 
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
$ docker-compose pull
$ docker-compose up
```
This might take a while, wait until you see "GanjoorAPI is connected to database" Which means everything went as expected.

## Making requests 
When server starts you will be provided with an access key which is something like this:
``` bash
new token with accessLevel developer: TOKENHERE
```

You should send that token on every request as header parameter like:
``` bash
Authorization: Barear TOKENHERE
```

can see the list of acceptable requests [here](https://github.com/ganjoor/GanjoorAPI-Swift/wiki/Requests)

This software is released under the [MIT License](LICENSE).
