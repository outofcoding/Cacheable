import Foundation

protocol Cacheable : Loggable {
    var path: String { get }
    var name: String { get }
}

extension Cacheable {
    private var root: String? {
        let domain = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let root = domain.first else { return nil }
        let path = "\(root)/\(self.path)"
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return path
        } catch {
            log("get root Error = \(error)")
            return nil
        }
    }
    
    private var file: String? {
        guard let root = root else { return nil }
        return "\(root)/\(name)"
    }
}

extension Cacheable {
    func write(data: Data?) {
        guard let file = file,
            let data = data else { return }
        
        do {
            let url = URL(fileURLWithPath: file)
            try data.write(to: url, options: .atomic)
            log("File Write to \"\(file)\"")
        } catch {
            log("File Write Error \"\(error)\"")
        }
    }
    
    func read() -> Data? {
        guard let file = file else { return nil }
        
        do {
            guard FileManager.default.fileExists(atPath: file) else {
                return nil
            }
            
            let string = try String(contentsOfFile: file, encoding: .utf8)
            log("File Read \"\(file)\" Success")
            let data = string.data(using: .utf8)
            return data
        } catch {
            log("File Read Error = \(error)")
            return nil
        }
    }
}
