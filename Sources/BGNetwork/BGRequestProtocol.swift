//
//  File.swift
//  
//
//  Created by Nilesh on 12/12/23.
//

import Foundation


public protocol BGRequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: BGRequestParameters? { get }
}
