import Foundation
import ZestySwiftContentEndpointWrapper
import SwiftyJSON

extension JSON {
    mutating func merge(other: JSON) {
        for (key, subJson) in other {
            self[key] = subJson
        }
    }

    func combine(with other: JSON) -> JSON {
        var merged = self
        merged.merge(other: other)
        return merged
    }
}
