//
//  MovieEndPoint.swift
//  NetworkManager
//
//  Created by Kasım on 5.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case movie(query: String, page:Int)
    case movieDetail(id: String)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
            case .production: return "http://www.omdbapi.com/"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .movie(_, _), .movieDetail(_):
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
            // case for send parameter(body)
            case .movie(let query, let page):
                return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [
                    "s": query,
                    "page": page,
                    "type": "movie",
                    "apikey":NetworkManager.MovieAPIKey
                ])
            case .movieDetail(let id):
                return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [
                    "i": id,
                    "apikey":NetworkManager.MovieAPIKey
                ])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


