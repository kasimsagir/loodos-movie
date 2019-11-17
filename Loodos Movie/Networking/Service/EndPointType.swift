//
//  EndPointType.swift
//  NetworkManager
//
//  Created by Kasım on 5.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
