//
//  Types.swift
//  BennyApplySDK
//
//  Created by Ariel Bong on 11/9/23.
//

import Foundation

// Parameters used to instantiate the Benny Apply ViewController or ViewControllerRepresentable
public struct BennyApplyParameters: Codable {
    var organizationId: String
    var externalId: String
    var environment: Environment
    public init(organizationId: String, externalId: String, environment: Environment) {
        self.organizationId = organizationId
        self.externalId = externalId
        self.environment = environment
    }
}

public enum Environment: Codable {
    case PRODUCTION, STAGING
}
