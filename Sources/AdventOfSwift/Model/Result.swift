import Foundation

struct Result: Codable {
    let members: [String: Member]
    let event: String
    let ownerId: Int
    
    enum CodingKeys: String, CodingKey {
        case members, event, ownerId = "owner_id"
    }
}
