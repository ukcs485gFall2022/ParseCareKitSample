//
//  Surveyable.swift
//  OCKSample
//
//  Created by Corey Baker on 11/14/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
#if canImport(ResearchKit)
import ResearchKit
#endif

protocol Surveyable {
    static var surveyType: Survey { get }
    static func identifier() -> String
    #if canImport(ResearchKit)
    func createSurvey() -> ORKTask
    func extractAnswers(_ result: ORKTaskResult) -> [OCKOutcomeValue]?
    #endif
}

extension Surveyable {
    static func identifier() -> String {
        surveyType.rawValue.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func identifier() -> String {
        Self.identifier()
    }
}
