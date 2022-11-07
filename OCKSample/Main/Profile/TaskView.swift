//
//  TaskView.swift
//  OCKSample
//
//  Created by  on 10/27/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    @State var asset = ""
    @StateObject var viewModel = TaskViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Add Task") {
            viewModel.instructions = "Hello"
            Task {
                await viewModel.addTask()
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
