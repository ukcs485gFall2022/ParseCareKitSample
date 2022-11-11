//
//  Survey+CheckIn.swift
//  OCKSample
//
//  Created by Corey Baker on 11/11/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import CareKitStore
import ResearchKit

extension Survey {
    static let checkInFormIdentifier = "\(Self.checkIn.identifier()).form"
    static let checkInPainItemIdentifier = "\(Self.checkIn.identifier()).form.pain"
    static let checkInSleepItemIdentifier = "\(Self.checkIn.identifier()).form.sleep"

    static func checkIn() -> ORKTask {

        let painAnswerFormat = ORKAnswerFormat.scale(
            withMaximumValue: 10,
            minimumValue: 1,
            defaultValue: 0,
            step: 1,
            vertical: false,
            maximumValueDescription: "Very painful",
            minimumValueDescription: "No pain"
        )

        let painItem = ORKFormItem(
            identifier: checkInPainItemIdentifier,
            text: "How would you rate your pain?",
            answerFormat: painAnswerFormat
        )
        painItem.isOptional = false

        let sleepAnswerFormat = ORKAnswerFormat.scale(
            withMaximumValue: 12,
            minimumValue: 0,
            defaultValue: 0,
            step: 1,
            vertical: false,
            maximumValueDescription: nil,
            minimumValueDescription: nil
        )

        let sleepItem = ORKFormItem(
            identifier: checkInSleepItemIdentifier,
            text: "How many hours of sleep did you get last night?",
            answerFormat: sleepAnswerFormat
        )
        sleepItem.isOptional = false

        let formStep = ORKFormStep(
            identifier: checkInFormIdentifier,
            title: "Check In",
            text: "Please answer the following questions."
        )
        formStep.formItems = [painItem, sleepItem]
        formStep.isOptional = false

        let surveyTask = ORKOrderedTask(
            identifier: Self.checkIn.identifier(),
            steps: [formStep]
        )
        return surveyTask
    }

    static func extractAnswersFromCheckInSurvey(
        _ result: ORKTaskResult) -> [OCKOutcomeValue]? {

        guard
            let response = result.results?
                .compactMap({ $0 as? ORKStepResult })
                .first(where: { $0.identifier == checkInFormIdentifier }),

            let scaleResults = response
                .results?.compactMap({ $0 as? ORKScaleQuestionResult }),

            let painAnswer = scaleResults
                .first(where: { $0.identifier == checkInPainItemIdentifier })?
                .scaleAnswer,

            let sleepAnswer = scaleResults
                .first(where: { $0.identifier == checkInSleepItemIdentifier })?
                .scaleAnswer
        else {
            assertionFailure("Failed to extract answers from check in survey!")
            return nil
        }

        var painValue = OCKOutcomeValue(Double(truncating: painAnswer))
        painValue.kind = checkInPainItemIdentifier

        var sleepValue = OCKOutcomeValue(Double(truncating: sleepAnswer))
        sleepValue.kind = checkInSleepItemIdentifier

        return [painValue, sleepValue]
    }
}
