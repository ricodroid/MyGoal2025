//
//  AddGoalView.swift
//  MyGoal2025
//
//  Created by r_murata on 2025/01/03.
//

import SwiftUI

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss // シートを閉じるための環境変数
    @State private var title: String = ""
    @State private var taskTitle: String = ""
    @State private var tasks: [Task] = []

    var onAddGoal: (Goal) -> Void // 新しい目標を渡すクロージャ

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Goal Title")) {
                    TextField("Enter goal title", text: $title)
                }
                Section(header: Text("Tasks")) {
                    TextField("Enter task title", text: $taskTitle)
                    Button(action: {
                        if !taskTitle.isEmpty {
                            tasks.append(Task(title: taskTitle, status: .notStarted, diary: ""))
                            taskTitle = "" // 入力欄をクリア
                        }
                    }) {
                        Text("Add Task")
                    }
                    List(tasks) { task in
                        Text(task.title)
                    }
                }
            }
            .navigationTitle("New Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss() // シートを閉じる
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !title.isEmpty {
                            let newGoal = Goal(title: title, tasks: tasks)
                            onAddGoal(newGoal) // クロージャを呼び出して目標を追加
                            dismiss() // シートを閉じる
                        }
                    }
                }
            }
        }
    }
}

