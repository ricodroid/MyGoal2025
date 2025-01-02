//
//  Models.swift
//  MyGoal2025
//
//  Created by r_murata on 2025/01/03.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var status: TaskStatus
    var diary: String
}

enum TaskStatus: String {
    case notStarted = "TODO"
    case inProgress = "DO"
    case completed = "DONE"
}

struct Goal: Identifiable {
    let id = UUID()
    var title: String
    var tasks: [Task]
}

