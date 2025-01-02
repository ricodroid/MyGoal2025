//
//  GoalDetailView.swift
//  MyGoal2025
//
//  Created by r_murata on 2025/01/03.
//

import SwiftUI


struct GoalDetailView: View {
    @State var goal: Goal

    var body: some View {
        VStack {
            Text(goal.title).font(.largeTitle)
                .padding()

            HStack(alignment: .top) {
                KanbanColumn(
                    title: "TODO",
                    tasks: goal.tasks.filter { $0.status == .notStarted },
                    onDrop: { droppedTask in
                        updateTaskStatus(task: droppedTask, to: .notStarted)
                    }
                )
                KanbanColumn(
                    title: "DO",
                    tasks: goal.tasks.filter { $0.status == .inProgress },
                    onDrop: { droppedTask in
                        updateTaskStatus(task: droppedTask, to: .inProgress)
                    }
                )
                KanbanColumn(
                    title: "DONE",
                    tasks: goal.tasks.filter { $0.status == .completed },
                    onDrop: { droppedTask in
                        updateTaskStatus(task: droppedTask, to: .completed)
                    }
                )
            }
            .padding()
            .frame(maxHeight: .infinity)
        }
        .navigationTitle("Goal Details")
    }

    // タスクのステータスを更新する
    private func updateTaskStatus(task: Task, to status: TaskStatus) {
        if let index = goal.tasks.firstIndex(where: { $0.id == task.id }) {
            goal.tasks[index].status = status
        }
    }
}

struct KanbanColumn: View {
    var title: String
    var tasks: [Task]
    var onDrop: (Task) -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            ForEach(tasks) { task in
                Text(task.title)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                    .onDrag {
                        NSItemProvider(object: task.id.uuidString as NSString)
                    }
            }
            .padding(4)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .onDrop(of: [.plainText], isTargeted: nil) { providers in
            handleDrop(providers: providers)
        }
    }

    // ドロップ処理
    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        for provider in providers {
            if provider.canLoadObject(ofClass: NSString.self) {
                _ = provider.loadObject(ofClass: NSString.self) { object, _ in
                    if let idString = object as? String,
                       let uuid = UUID(uuidString: idString),
                       let droppedTask = tasks.first(where: { $0.id == uuid }) {
                        DispatchQueue.main.async {
                            onDrop(droppedTask)
                        }
                    }
                }
                return true
            }
        }
        return false
    }
}


struct TaskColumnView: View {
    @Binding var tasks: [Task]
    var status: TaskStatus
    var title: String
    var onTaskTap: (Task) -> Void // タスクをタップしたときのアクション

    var body: some View {
        VStack {
            Text(title).font(.headline)
            ForEach(tasks.filter { $0.status == status }) { task in
                Text(task.title)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .onTapGesture {
                        onTaskTap(task) // タップ時にアクションを実行
                    }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
