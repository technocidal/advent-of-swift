import OSLog
import Foundation
import ArgumentParser

@main
struct AdventOfSwift: AsyncParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Solutions for AoC problems",
        subcommands: [
            First.self
        ]
    )
}

struct First: AsyncParsableCommand {
    
    func run() async throws {}
}

