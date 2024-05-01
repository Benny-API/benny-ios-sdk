//
//  TransferTypes.swift
//  
//
//  Created by Ariel Bong on 4/30/24.
//

import Foundation

public typealias EbtTransferLinkCardParameters = EbtBalanceParameters

public struct EbtTransferCheckBalanceParameters: Codable {
    public var organizationId: String
    public var transferToken: String
}

public typealias EbtTransferParameters = EbtTransferCheckBalanceParameters

public struct ExchangeTemporaryLinkResponse: Codable {
    public var transferToken: String
    public var expiration: String
}
