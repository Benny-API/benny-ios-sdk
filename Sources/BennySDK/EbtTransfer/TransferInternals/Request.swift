//
//  Request.swift
//
//
//  Created by Ariel Bong on 5/1/24.
//

import Foundation

public var ProductionBaseURL = "https://api-production.bennyapi.com"
public var SandboxBaseURL = "https://api-sandbox.bennyapi.com"

enum NetworkError: Error {
    case badURL
    case requestFailed(reason: String)
    case unexpectedStatusCode(code: Int)
}

func getBaseURL(env: Environment) -> String {
    switch env {
    case Environment.SANDBOX:
        return SandboxBaseURL
    case Environment.PRODUCTION:
        return ProductionBaseURL
    default:
        return ProductionBaseURL
    }
}

func createPostRequest(urlString: String, postData: Codable, headers: [String: String]) throws -> URLRequest {
    let url = URL(string: urlString)!
    let httpBody = try JSONEncoder().encode(postData)

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = httpBody

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    headers.forEach {
        request.addValue($1, forHTTPHeaderField: $0)
    }
    return request
}

func postRequest<T: Decodable>(request: URLRequest, responseType: T.Type) async throws -> T {
    let (data, response) = try await URLSession.shared.data(for: request)
    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
        // Attempt to decode the error if the status code is not 200
        do {
            let errorResponse = try JSONDecoder().decode(EbtTransferApiError.self, from: data)
            throw errorResponse
        }
    }
    return try JSONDecoder().decode(responseType, from: data)
}

func postExchangeTemporaryLinkRequest(
    env: Environment,
    organizationId: String,
    request: ExchangeTemporaryLinkRequest
) async -> Result<ExchangeTemporaryLinkResponse, EbtTransferApiError> {
    let urlString = getBaseURL(env: env) + "/v1/ebt/transfer/link/exchange"
    let headers = ["benny-organization": organizationId]
    do {
        let urlRequest = try createPostRequest(urlString: urlString, postData: request, headers: headers)
        let response = try await postRequest(request: urlRequest, responseType: ExchangeTemporaryLinkResponse.self)
        return .success(response)
    } catch let error as EbtTransferApiError {
        return .failure(error)
    } catch {
        return .failure(EbtTransferApiError(type: "EBT_TRANSFER_API_ERROR", code: TransferApiErrorCode.unknown, message: "Unknown error."))
    }
}

func postCheckBalanceRequest(
    env: Environment,
    organizationId: String,
    request: CheckBalanceRequest
) async -> Result<CheckBalanceResponse, EbtTransferApiError> {
    let urlString = getBaseURL(env: env) + "/v1/ebt/transfer/check-balance"
    let headers = ["benny-organization": organizationId]
    do {
        let urlRequest = try createPostRequest(urlString: urlString, postData: request, headers: headers)
        let response = try await postRequest(request: urlRequest, responseType: CheckBalanceResponse.self)
        return .success(response)
    } catch let error as EbtTransferApiError {
        return .failure(error)
    } catch {
        return .failure(EbtTransferApiError(type: "EBT_TRANSFER_API_ERROR", code: TransferApiErrorCode.unknown, message: "Unknown error."))
    }
}

func postTransferRequest(
    env: Environment,
    organizationId: String,
    request: TransferRequest
) async -> Result<TransferResponse, EbtTransferApiError> {
    let urlString = getBaseURL(env: env) + "/v1/ebt/transfer"
    let headers = ["benny-organization": organizationId]
    do {
        let urlRequest = try createPostRequest(urlString: urlString, postData: request, headers: headers)
        let response = try await postRequest(request: urlRequest, responseType: TransferResponse.self)
        return .success(response)
    } catch let error as EbtTransferApiError {
        return .failure(error)
    } catch {
        return .failure(EbtTransferApiError(type: "EBT_TRANSFER_API_ERROR", code: TransferApiErrorCode.unknown, message: "Unknown error."))
    }
}
