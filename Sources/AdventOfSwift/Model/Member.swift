import Foundation

/// JSON Example
///
/// {
///     "global_score": 0,
///     "local_score": 0,
///     "completion_day_level": {
///         "1": {
///             "1": {
///                 "star_index": 0,
///                 "get_star_ts": 0
///             },
///             "2": {
///                 "star_index": 0,
///                 "get_star_ts": 0
///             }
///         }
///     },
///     "id": 0,
///     "last_star_ts": 0,
///     "stars": 0,
///     "name": "John Doe"
/// }
struct Member: Codable {
    let id: Int
    let globalScore: Int
    let localScore: Int
    let stars: Int
    let name: String
    let lastStarTimestamp: Int
    
    enum CodingKeys: String, CodingKey {
        case id, stars, name, globalScore = "global_score", localScore = "local_score", lastStarTimestamp = "last_star_ts"
    }
}

extension Member: Comparable {
    
    static func < (lhs: Member, rhs: Member) -> Bool {
        if lhs.localScore == rhs.localScore {
            return lhs.lastStarTimestamp < rhs.lastStarTimestamp
        } else {
            return lhs.localScore < rhs.localScore
        }
    }
}
