import Foundation

var token: String {
    guard let token = ProcessInfo.processInfo.environment["AOC_TOKEN"] else {
        fatalError("Error: Environment variable `AOC_TOKEN` isn't set!")
    }
    
    return token
}

var leaderboard: String {
    guard let leaderboard = ProcessInfo.processInfo.environment["AOC_LEADERBOARD"] else {
        fatalError("Error: Environment variable `AOC_TOKEN` isn't set!")
    }
    
    return leaderboard
}

struct Door {
    let day: Int
    let year: Int
}

func getInput(_ door: Door) async throws -> String {
    let url = URL(string: "https://adventofcode.com/\(door.year)/day/\(door.day)/input")!
    var request = URLRequest(url: url)
    request.addValue("session=\(token)", forHTTPHeaderField: "Cookie")
    let result = try await URLSession.shared.data(for: request)
    guard let input = String(data: result.0, encoding: .utf8) else {
        fatalError("Error: Parsing input failed!")
    }
    return input
}
