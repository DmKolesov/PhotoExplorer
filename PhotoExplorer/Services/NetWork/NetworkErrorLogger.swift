//
//  NetworkErrorLogger.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 22.09.2023.
//

import Foundation

protocol NetworkErrorLogger {
    func log(error: Error)
}

final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    func log(error: Error) {
        print("Network error: \(error.localizedDescription)")
    }
}
