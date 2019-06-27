# Cacheable
path, name을 마음대로 지정하는 파일 저장 protocol (path = 저장 폴더, name = 파일 이름)

Example create NetworkCache...
```
struct NetworkCache : Cacheable {
    var path: String { return "ApiCache" }
    var name: String
    
    var logTag: String { return "NetworkCache" }
    var logEnable: Bool { return true }
    
    init(target: String) {
        name = target
    }
}
```

Use NetworkCache
```
let login = Data() // some Data Data

let cache = NetworkCache("login")
cache.write(login) // write data

let storeData = cache.read() // read data
```
