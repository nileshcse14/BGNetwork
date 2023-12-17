//
//  File.swift
//  
//
//  Created by Nilesh on 14/12/23.
//

import Foundation

public final class BGRequestBuilder: BGrequest {
   
    private var baseURL: URL
    private var path: String
    private var method: HTTPMethod = .get
    private var headers: [String: String]?
    private var parameters: BGRequestParameters?
    
    public init(baseURL: URL, path: String) {
        self.baseURL = baseURL
        self.path = path
    }
    
    @discardableResult
    public func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    public func set(path: String) -> Self {
        self.path = path
        return self
    }
    
    @discardableResult
    public func set(headers: [String : String]?) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    public func set(parameters: BGRequestParameters) -> Self {
        self.parameters = parameters
        return self
    }
    
    public func build() throws -> URLRequest {
        var url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 50)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        setupBody(urlRequest: &urlRequest)
        return urlRequest
        
    }
    
    private func setupBody(urlRequest: inout URLRequest) {
        if let parameters = parameters {
            switch parameters {
            case .body(let bodyParam):
               setupRequestBody(bodyParam, for: &urlRequest)
            case .url(let urlParam):
                setupRequestURLBody(urlParam, for: &urlRequest)
            }
        }
    }
    
    private func setupRequestBody(_ parameters: [String: Any]?, for request: inout URLRequest) {
        if let parameters = parameters {
            let data = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = data
        }
    }
    
    private func setupRequestURLBody(_ parameters: [String: String]?, for request: inout URLRequest) {
        if let parameters = parameters,
           let url = request.url,
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            request.url = urlComponents.url
            
        }
    }
    
    
}
