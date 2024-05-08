//
//  TransferTypes.swift
//  
//
//  Created by Ariel Bong on 4/30/24.
//

import Foundation

public typealias EbtTransferLinkCardParameters = EbtBalanceParameters

public struct EbtTransferBalanceParameters: Codable {
    public var organizationId: String
    public var transferToken: String
    public var environment: Environment
    public init(organizationId: String, transferToken: String, environment: Environment) {
        self.organizationId = organizationId
        self.transferToken = transferToken
        self.environment = environment
    }
}

public struct EbtTransferParameters: Codable {
    public var organizationId: String
    public var transferToken: String
    public var environment: Environment
    public var idempotencyKey: String
    public var amount: Int
    public init(organizationId: String, transferToken: String,  idempotencyKey: String, amount: Int, environment: Environment) {
        self.organizationId = organizationId
        self.transferToken = transferToken
        self.environment = environment
        self.idempotencyKey = idempotencyKey
        self.amount = amount
    }
}

public struct ExchangeTemporaryLinkRequest: Codable {
    public var temporaryLink: String
    public var accountNumber: String
    public var pin: String
}

public struct ExchangeTemporaryLinkResponse: Codable {
    public var transferToken: String
    public var expiration: String
}

public struct CheckBalanceRequest: Codable {
    public var transferToken: String
    public var pin: String
}

public struct CheckBalanceResponse: Codable {
    public var balance: Int?
    public var numAttemptsLeft: Int?
}

public struct TransferRequest: Codable {
    public var idempotencyKey: String
    public var amount: Int
    public var transferToken: String
    public var pin: String
}

public struct TransferResponse: Codable {
}

public struct EbtTransferApiError: Codable, Error {
    public var type: String
    public var code: TransferApiErrorCode
    public var message: String
}

public enum TransferApiErrorCode: String, Codable {
    case existingIdempotencyKey =
        "EXISTING_IDEMPOTENCY_KEY"
    case expiredLinkToken =
        "EXPIRED_LINK_TOKEN"
    case expiredTransferToken =
        "EXPIRED_TRANSFER_TOKEN"
    case failedGetingReconciliationFile =
        "FAILED_GETTING_RECONCILIATION_FILE"
    case insufficientFunds =
        "INSUFFICIENT_FUNDS"
    case invalidAccountSetup =
        "INVALID_ACCOUNT_SETUP"
    case invalidCardInfo =
        "INVALID_CARD_INFO"
    case invalidLinkToken =
        "INVALID_LINK_TOKEN"
    case invalidOrganization =
        "INVALID_ORGANIZATION"
    case invalidReconciliationId =
        "INVALID_RECONCILIATION_ID"
    case invalidTransferToken =
        "INVALID_TRANSFER_TOKEN"
    case invalidUserId =
        "INVALID_USER_ID"
    case maxAttemptsExceeded =
        "MAX_ATTEMPTS_EXCEEDED"
    case pinTimeout =
        "PIN_TIMEOUT"
    case transferFailed =
        "TRANSFER_FAILED"
    case unknown =
        "UNKNOWN"
}
