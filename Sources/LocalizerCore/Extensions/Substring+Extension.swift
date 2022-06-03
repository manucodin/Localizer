import Foundation

extension Substring {
    func clean() -> String {
        return self.trimmingCharacters(in: ["("," ",":","\"",")"])
    }
}
