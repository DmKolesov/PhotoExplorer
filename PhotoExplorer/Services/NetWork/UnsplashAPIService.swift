//
//  UnsplashAPIService.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 22.09.2023.
//

import Foundation
import Alamofire

final class UnsplashAPIService {
    private let apiKey = Resources.Strings.NetWork.apiKey
    private let errorLogger: NetworkErrorLogger

    init(errorLogger: NetworkErrorLogger) {
        self.errorLogger = errorLogger
    }

    func fetchRandomPhotos(count: Int, completion: @escaping (Result<[UnsplashInfoData], NetworkError>) -> Void) -> NetworkCancellable {
        let endpoint = Resources.Strings.NetWork.randomEndpoint
        let parameters: Parameters = [
            "count": count
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(apiKey)"
        ]

        let request = AF.request(endpoint, parameters: parameters, headers: headers)
            .responseDecodable(of: [UnsplashInfoData].self) { response in
                switch response.result {
                case .success(let searchResponse):
                    completion(.success(searchResponse))
                case .failure(let error):
                    let networkError = self.mapAlamofireError(error)
                    self.errorLogger.log(error: networkError)
                    completion(.failure(networkError))
                }
            }

        return NetworkCancellableWrapper(request: request)
    }

    func searchPhotos(query: String, completion: @escaping (Result<[UnsplashInfoData], NetworkError>) -> Void) -> NetworkCancellable {
        let endpoint = Resources.Strings.NetWork.searchEndpoint
        let parameters: Parameters = [
            "query": query,
            "per_page": 30
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(apiKey)"
        ]

        let request = AF.request(endpoint, parameters: parameters, headers: headers)
            .responseDecodable(of: UnsplashInfoSearchResponse.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    completion(.success(searchResponse.results))
                case .failure(let error):
                    let networkError = self.mapAlamofireError(error)
                    self.errorLogger.log(error: networkError)
                    completion(.failure(networkError))
                }
            }
        
        return NetworkCancellableWrapper(request: request)
    }

    private func mapAlamofireError(_ error: AFError) -> NetworkError {
        if let urlError = error.underlyingError as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return .noInternetConnection
            default:
                return .generic(error)
            }
        }

        switch error.responseCode {
        case 401:
            return .invalidRequest
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500:
            return .serverError
        default:
            break
        }

        if error.isResponseSerializationError {
            return .invalidResponse
        }

        if error.isSessionTaskError, let underlyingError = error.underlyingError as? NSError {
            switch underlyingError.code {
            case NSURLErrorTimedOut:
                return .timeout
            case NSURLErrorCancelled:
                return .canceled
            default:
                break
            }
        }

        return .generic(error)
    }
}
