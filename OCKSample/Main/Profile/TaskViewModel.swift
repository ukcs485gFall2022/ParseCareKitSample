//
//  TaskViewModel.swift
//  OCKSample
//
//  Created by  on 10/27/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
import os.log

class TaskViewModel: ObservableObject {
    @Published var title = ""
    @Published var instructions = ""
    @Published var error: AppError? {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }

    // MARK: Intents
    func addTask() async {
        guard let appDelegate = AppDelegateKey.defaultValue else {
            error = AppError.couldntBeUnwrapped
            return
        }
        let uniqueId = UUID().uuidString // Create a unique id for each task
        var task = OCKTask(id: uniqueId,
                           title: title,
                           carePlanUUID: nil,
                           schedule: .dailyAtTime(hour: 0,
                                                  minutes: 0,
                                                  start: Date(),
                                                  end: nil,
                                                  text: nil))
        task.instructions = instructions
        do {
            try await appDelegate.storeManager.addTasksIfNotPresent([task])
            Logger.task.info("Saved task: \(task.id, privacy: .private)")
        } catch {
            self.error = AppError.errorString("Couldn't add task: \(error.localizedDescription)")
        }
    }

    func addHealthKitTask() async {
        guard let appDelegate = AppDelegateKey.defaultValue else {
            error = AppError.couldntBeUnwrapped
            return
        }
        let uniqueId = UUID().uuidString // Create a unique id for each task
        var healthKitTask = OCKHealthKitTask(id: uniqueId,
                                             title: title,
                                             carePlanUUID: nil,
                                             schedule: .dailyAtTime(hour: 0,
                                                                    minutes: 0,
                                                                    start: Date(),
                                                                    end: nil,
                                                                    text: nil),
                                             healthKitLinkage: .init(quantityIdentifier: .electrodermalActivity,
                                                                     quantityType: .discrete,
                                                                     unit: .count()))
        healthKitTask.instructions = instructions
        do {
            try await appDelegate.storeManager.addTasksIfNotPresent([healthKitTask])
            // Ask HealthKit store for permissions after each new task
            Utility.requestHealthKitPermissions()
            Logger.task.info("Saved HealthKitTask: \(healthKitTask.id, privacy: .private)")
        } catch {
            self.error = AppError.errorString("Couldn't add task: \(error.localizedDescription)")
        }
    }
}