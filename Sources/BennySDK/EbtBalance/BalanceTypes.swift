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
    public var type = "CopyToClipboard"
    public var label: String
    public var text: String
}

/*
 * Deprecated and replaced by LinkResultMessage.
 */

public struct LinkSuccessMessage: Codable {
    public var type: String
    public var linkToken: String
}

public struct LinkResultMessage: Codable {
    public var type = "LinkResult"
    public var result: LinkResult
}

public typealias LinkResult = LinkResultSuccess

public struct LinkResultSuccess: Codable {
    public var type = "LinkResultSuccess"
    public var linkToken: String
    public var accountId: String
    public var accountHolder: AccountHolder
}

public struct AccountHolder: Codable {
    public var name: String?
    public var address: String?
    public var balances: Balances
    public var lastTransactionDate: String?
}

public struct Balances: Codable {
    public var snap: Double?
    public var cash: Double?
}

public struct OpenUrlMessage: Codable {
    public var type = "OpenUrlExternally"
    public var url: String
}
