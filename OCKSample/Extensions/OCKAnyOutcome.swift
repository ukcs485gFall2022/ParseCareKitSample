//
//  OCKAnyOutcome.swift
//  OCKSample
//
//  Created by Corey Baker on 12/3/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import CareKitStore

extension OCKAnyOutcome {

    func answerDouble(kind: String) -> [Double] {
        let doubleValues = values.compactMap({ value -> Double? in
            guard value.kind == kind else {
                return nil
            }
            guard let intValue = value.integerValue else {
                return value.doubleValue
            }
            return Double(intValue)
        })
        return doubleValues
    }

    func answerString(kind: String) -> [String] {
        let stringValues = values.compactMap { value -> String? in
            guard value.kind == kind else {
                return nil
            }
            return value.stringValue
        }
        return stringValues
    }
}
