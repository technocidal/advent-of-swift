import Foundation

struct Door {
    let day: Int
    let year: Int
}

func getInput(_ door: Door) async throws -> String {
    guard let token = ProcessInfo.processInfo.environment["AOC_TOKEN"] else {
        print("Error: Environment variable `AOC_TOKEN` isn't set!")
        exit(1)
    }
    let url = URL(string: "https://adventofcode.com/\(door.year)/day/\(door.day)/input")!
    var request = URLRequest(url: url)
    request.addValue("session=\(token)", forHTTPHeaderField: "Cookie")
    let result = try await URLSession.shared.data(for: request)
    guard let input = String(data: result.0, encoding: .utf8) else {
        print("Error: Parsing input failed!")
        exit(1)
    }
    return input
}
