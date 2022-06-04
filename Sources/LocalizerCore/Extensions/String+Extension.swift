import Foundation

extension String {
    func clean() -> String {
        return self.trimmingCharacters(in: ["("," ",":","\"",")","\n","\\"])
    }
}
