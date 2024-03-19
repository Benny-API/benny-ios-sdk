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

public struct CopyToClipboardMessage: Codable {
    var type = "CopyToClipboard"
    var label: String
    var text: String
}

public struct LinkSuccessMessage: Codable {
    var type: String
    var linkToken: String
}

public struct OpenUrlMessage: Codable {
    var type = "OpenUrlExternally"
    var url: String
}
