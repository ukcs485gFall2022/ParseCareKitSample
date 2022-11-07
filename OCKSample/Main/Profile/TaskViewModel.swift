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
    @Published var instructions = ""
    @Published var task = OCKTask(id: "",
                                  title: nil,
                                  carePlanUUID: nil,
                                  schedule: .dailyAtTime(hour: 0,
                                                         minutes: 0,
                                                         start: Date(),
                                                         end: nil,
                                                         text: nil))
    @Published var healthKitTask = OCKHealthKitTask(id: "",
                                                    title: nil,
                                                    carePlanUUID: nil,
                                                    schedule: .dailyAtTime(hour: 0,
                                                                           minutes: 0,
                                                                           start: Date(),
                                                                           end: nil,
                                                                           text: nil),
                                                        
                                                    healthKitLinkage: .init(quantityIdentifier: .electrodermalActivity,
                                                                            quantityType: .cumulative,
                                                                            unit: .count()))
    @Published var error: AppError?
    
    // MARK: Intents
    func addTask() async {
        guard let appDelegate = AppDelegateKey.defaultValue else {
            error = AppError.couldntBeUnwrapped
            return
        }
        
        var updatedTask = task
        if instructions != updatedTask.instructions {
            updatedTask.instructions = instructions
        }
        
        do {
            let taskInStore = try await appDelegate.storeManager.store.addAnyTask(updatedTask) //.addTasksIfNotPresent([updatedTask])
            Logger.task.info("Saved task: \(taskInStore.id, privacy: .private)")
        } catch {
            self.error = AppError.errorString("Couldn't add task: \(error.localizedDescription)")
        }
    }

    func addHealthKitTask() async {
        guard let appDelegate = AppDelegateKey.defaultValue else {
            error = AppError.couldntBeUnwrapped
            return
        }
        
        var updatedHealthKitTask = healthKitTask
        if instructions != updatedHealthKitTask.instructions {
            updatedHealthKitTask.instructions = instructions
        }
        
        do {
            try await appDelegate.healthKitStore?.addTasksIfNotPresent([updatedHealthKitTask]) // try await appDelegate.storeManager.store.addAnyTask(updatedHealthKitTask) //
            // Logger.task.info("Saved task: \(taskInStore.id, privacy: .private)")
        } catch {
            self.error = AppError.errorString("Couldn't add task: \(error.localizedDescription)")
        }
    }
}
