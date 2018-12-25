import Foundation

struct NetworkCache : Cacheable {
    var path: String { return "ApiCache" }
    var name: String
    
    var logTag: String { return "NetworkCache" }
    var logEnable: Bool { return true }
    
    init(target: String) {
        name = target
    }
}
