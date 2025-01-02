//
//  DiaryView.swift
//  MyGoal2025
//
//  Created by r_murata on 2025/01/03.
//

import SwiftUI

struct DiaryView: View {
    @Binding var task: Task

    var body: some View {
        VStack {
            Text("Diary for \(task.title)").font(.headline)
            TextEditor(text: $task.diary)
                .border(Color.gray, width: 1)
                .padding()
            Spacer()
        }
        .padding()
        .navigationTitle("Edit Diary")
    }
}
