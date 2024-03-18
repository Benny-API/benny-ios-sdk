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
    var externalId: String
    var environment: Environment?
    public init(organizationId: String, externalId: String, environment: Environment) {
        self.organizationId = organizationId
        self.externalId = externalId
        self.environment = environment
    }
}

public enum Environment: Codable {
    case PRODUCTION, SANDBOX
}
