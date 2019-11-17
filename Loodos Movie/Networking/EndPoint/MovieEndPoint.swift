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
    case newMovies(page:Int)
    case movieDetail(id:Int)
    case movieCast(id:Int)
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
        case .newMovies:
            return ""
        case .movieDetail(let id):
            return "\(id)"
        case .movieCast(let id):
            return "\(id)/credits"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
        case .movieDetail(_), .movieCast(_):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


