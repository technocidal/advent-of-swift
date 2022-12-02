import OSLog
import Foundation
import ArgumentParser

@main
struct AdventOfSwift: AsyncParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Solutions for AoC problems",
        subcommands: [
            Leaderboard.self,
            First.self,
            Second.self
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
    
    func run() async throws {
        let counts = try await getInput(.init(day: 1, year: 2022))
            .components(separatedBy: .newlines)
            .reduce(into: [[]]) { partialResult, input in
                if input.isEmpty {
                    partialResult.append([String]())
                } else {
                    partialResult[partialResult.count - 1].append(input)
                }
            }
            .reduce(into: []) { partialResult, input in
                partialResult.append(
                    input
                        .compactMap{ Int($0) }
                        .reduce(into: 0) { $0 += $1 }
                )
            }
        
        print("The top elf is carrying \(counts.max() ?? 0) calories.")
        
        let lastThree = counts
            .sorted()
            .suffix(3)
            .reduce(into: 0) { $0 += $1 }
        
        print("The top three elves are carrying \(lastThree) calories.")
    }
}

struct Second: AsyncParsableCommand {
    
    func run() async throws {
        let input = try await getInput(.init(day: 2, year: 2022))
        
        var rounds = input.components(separatedBy: .newlines)
        _ = rounds.removeLast()
        var score1 = rounds.reduce(into: 0) { $0 += getRoundScore($1) }
        
        print("Total score for the first part \(score1)")
        
        var score2 = rounds.map({ getActualRound($0) }).reduce(into: 0) { $0 += getRoundScore($1) }
        
        print("Total score for the second part \(score2)")
    }
    
    private func checkWinning(_ input: String) -> Bool {
        ["A Y", "B Z", "C X"].contains([input])
    }
    
    private func checkTie(_ input: String) -> Bool {
        ["A X", "B Y", "C Z"].contains([input])
    }
    
    private func getBaseScore(_ input: String) -> Int {
        switch input {
        case "X":
            return 1
        case "Y":
            return 2
        default:
            return 3
        }
    }
    
    private func getRoundScore(_ input: String) -> Int {
        var score = 0
        if checkWinning(input) {
            score += 6
        } else if checkTie(input) {
            score += 3
        }
        
        score += getBaseScore(input.components(separatedBy: .whitespaces)[1])
        return score
    }
    
    private func getActualRound(_ input: String) -> String {
        let components = input.components(separatedBy: .whitespaces)
        let opponent = components[0]
        let round = components[1]
        switch round {
        case "X":
            switch opponent {
            case "A": return "A Z"
            case "B": return "B X"
            default: return "C Y"
            }
        case "Z":
            switch opponent {
            case "A": return "A Y"
            case "B": return "B Z"
            default: return "C X"
            }
            
        default:
            switch opponent {
            case "A": return "A X"
            case "B": return "B Y"
            default: return "C Z"
            }
        }
    }
}
