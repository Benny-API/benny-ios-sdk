//
//  Types.swift
//  EbtBalance
//
//  Created by Ariel Bong on 3/18/24.
//

import Foundation

// Parameters used to instantiate the EbtBalance ViewController or
// ViewControllerRepresentable

public struct EbtBalanceParameters: Codable {
    var organizationId: String
    var temporaryLink: String
    var environment: Environment?
    public init(organizationId: String, environment: Environment, temporaryLink: String) {
        self.organizationId = organizationId
        self.environment = environment
        self.temporaryLink = temporaryLink
    }
}

public enum Environment: Codable {
    case PRODUCTION, SANDBOX
}
