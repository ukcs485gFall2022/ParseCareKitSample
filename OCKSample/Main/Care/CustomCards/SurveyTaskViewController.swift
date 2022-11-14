//
//  SurveyTaskViewController.swift
//  OCKSample
//
//  Created by Corey Baker on 11/12/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitUI
import CareKit
import UIKit
import ResearchKit

class SurveyTaskViewController: OCKSurveyTaskViewController {
    override func taskView(_ taskView: UIView & OCKTaskDisplayable,
                           didCompleteEvent isComplete: Bool,
                           at indexPath: IndexPath,
                           sender: Any?) {
        guard isComplete else {
            if let event = controller.eventFor(indexPath: indexPath),
               let delegate = surveyDelegate,
               delegate.surveyTask(
                    viewController: self,
                    shouldAllowDeletingOutcomeForEvent: event) == false {
                return
            }

            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )

            let confirmAction = UIAlertAction(
                title: "Delete", style: .destructive) { _ in

                super.taskView(
                    taskView,
                    didCompleteEvent: isComplete,
                    at: indexPath,
                    sender: sender
                )
            }

            let warningAlert = UIAlertController(
                title: "Delete",
                message: "Are you sure you want to delete your response?",
                preferredStyle: .actionSheet
            )

            warningAlert.addAction(cancelAction)
            warningAlert.addAction(confirmAction)
            present(warningAlert, animated: true, completion: nil)

            return
        }

        let surveyViewController = ORKTaskViewController(
            task: survey,
            taskRun: nil
        )

        let directory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).last!.appendingPathComponent("ResearchKit", isDirectory: true)

        surveyViewController.outputDirectory = directory
        surveyViewController.delegate = self
        if self.view.window?.tintColor == nil {
            surveyViewController.view.tintColor = view.tintColor
        }
        present(surveyViewController, animated: true, completion: nil)
    }
}
