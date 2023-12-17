//
//  File.swift
//  
//
//  Created by Nilesh on 14/12/23.
//

import Foundation

public protocol BGrequest {
    init(baseURL: URL, path: String)
    
    @discardableResult
    func set(method: HTTPMethod) -> Self
    
    @discardableResult
    func set(path: String) -> Self
    
    @discardableResult
    func set(headers: [String: String]?) -> Self
    
    @discardableResult
    func set(parameters: BGRequestParameters) -> Self
    
    func build() throws -> URLRequest
    
    
}
