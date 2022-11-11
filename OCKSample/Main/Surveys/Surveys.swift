//
//  Surveys.swift
//  OCKSample
//
//  Created by Corey Baker on 11/11/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
#if canImport(ResearchKit)
import ResearchKit
#endif

enum Survey: String, CaseIterable, Identifiable {
    var id: Self { self }
    case onboard = "Onboard"
    case checkIn = "Check In"
    case rangeOfMotion = "Range of Motion"

    func identifier() -> String {
        self.rawValue.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#if canImport(ResearchKit)
extension Survey {
    func researchKitTask() -> ORKTask {
        switch self {
        case .onboard:
            return Self.onboarding()
        case .checkIn:
            return Self.checkIn()
        case .rangeOfMotion:
            return Self.rangeOfMotion()
        }
    }

    func extractAnswersFromSurvey(_ result: ORKTaskResult) -> [OCKOutcomeValue]? {
        switch self {
        case .onboard:
            return Self.extractAnswersFromOnboardSurvey(result)
        case .checkIn:
            return Self.extractAnswersFromCheckInSurvey(result)
        case .rangeOfMotion:
            return Self.extractAnswersFromRangeOfMotionSurvey(result)
        }
    }
}
#endif
