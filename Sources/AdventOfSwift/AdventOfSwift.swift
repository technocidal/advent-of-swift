import OSLog
import Foundation
import ArgumentParser

@main
struct AdventOfSwift: AsyncParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Solutions for AoC problems",
        subcommands: [
            Leaderboard.self,
            First.self
        ]
    )
}

struct Leaderboard: AsyncParsableCommand {
    
    enum NumberOfResults: ExpressibleByArgument {
        case all
        case number(Int)
        
        init?(argument: String) {
            if argument == "all" {
                self = .all
            } else if let number = Int(argument) {
                self = .number(number)
                
            } else if argument.starts(with: "number(") {
                var argument = argument.replacingOccurrences(of: "number(", with: "")
                argument = argument.replacingOccurrences(of: ")", with: "")
                self.init(argument: argument)
            } else {
                return nil
            }
        }
    }
    
    @Option(wrappedValue: .number(10), help: "The number of participants starting from the top")
    var numberOfResults: NumberOfResults
    
    func run() async throws {
        let leaderboard = leaderboard.components(separatedBy: "-").first ?? ""
        
        let url = URL(string: "https://adventofcode.com/2022/leaderboard/private/view/\(leaderboard).json")!
        var request = URLRequest(url: url)
        request.addValue("session=\(token)", forHTTPHeaderField: "Cookie")
        let response = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(Result.self, from: response.0)
        
        let sorted: [Member]
        switch numberOfResults {
        case .all:
            sorted = Array(result.members.values.sorted(by: >))
        case .number(let int):
            sorted = Array(result.members.values.sorted(by: >)[0..<int])
        }
        
        sorted.forEach { member in
            print("\(member.localScore) \(member.name)")
        }
    }
}

struct First: AsyncParsableCommand {
    
    func run() async throws {}
}

