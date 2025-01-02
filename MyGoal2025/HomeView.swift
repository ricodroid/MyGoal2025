//
//  HomeView.swift
//  MyGoal2025
//
//  Created by r_murata on 2025/01/03.
//

import SwiftUI

struct HomeView: View {
@State private var goals: [Goal] = [
]
@State private var isAddingGoal = false

var body: some View {
       NavigationView {
           List {
               ForEach(goals) { goal in
                   NavigationLink(destination: GoalDetailView(goal: goal)) {
                       Text("\(goal.title)")
                   }
               }
           }
           .navigationTitle("My Goals 2025")
           .toolbar {
               Button(action: {
                   isAddingGoal = true // シートを表示
               }) {
                   Image(systemName: "plus")
               }
           }
           .sheet(isPresented: $isAddingGoal) {
               AddGoalView { newGoal in
                   goals.append(newGoal) // 新しい目標をリストに追加
                   isAddingGoal = false // シートを閉じる
               }
           }
       }
   }
}

