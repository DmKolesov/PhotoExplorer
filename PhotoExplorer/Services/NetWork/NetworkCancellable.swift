//
//  NetworkCancellable.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 29.09.2023.
//

import Foundation
import Alamofire

protocol NetworkCancellable {
    func cancel()
}

struct NetworkCancellableWrapper: NetworkCancellable {
    private let request: DataRequest

    init(request: DataRequest) {
        self.request = request
    }

    func cancel() {
        request.cancel()
    }
}
