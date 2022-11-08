//
//  TaskView.swift
//  OCKSample
//
//  Created by  on 10/27/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel = TaskViewModel()

    var body: some View {
        NavigationView {
            Form {
                TextField("Title",
                          text: $viewModel.title)
                TextField("Instructions",
                          text: $viewModel.instructions)
                Picker("Card View", selection: $viewModel.selectedCard) {
                    ForEach(CareKitCard.allCases) { item in
                        Text(item.rawValue)
                    }
                }
                Section("Task") {
                    Button("Add") {
                        Task {
                            await viewModel.addTask()
                        }
                    }
                }
                Section("HealthKitTask") {
                    Button("Add") {
                        Task {
                            await viewModel.addHealthKitTask()
                        }
                    }
                }
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
