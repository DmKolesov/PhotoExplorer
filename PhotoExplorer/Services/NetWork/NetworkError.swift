//
//  NetworkError.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 22.09.2023.
//

import Foundation

enum NetworkError: Error {
    case generic(Error)
    case invalidResponse
    case noInternetConnection
    case invalidRequest
    case forbidden
    case notFound
    case serverError
    case timeout
    case canceled
    case unknown(Int)
    
    var localizedDescription: String {
        switch self {
        case .generic(let error):
            return "Generic Error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid Response"
        case .noInternetConnection:
            return "No Internet Connection"
        case .invalidRequest:
            return "Invalid Request"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .serverError:
            return "Server Error"
        case .timeout:
            return "Request Timeout"
        case .canceled:
            return "Request Canceled"
        case .unknown(let code):
            return "Unknown Error (Code: \(code))"
        }
    }
}
