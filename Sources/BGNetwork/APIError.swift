//
//  File.swift
//  
//
//  Created by Nilesh on 12/12/23.
//

import Foundation

public enum APIError: Error {
    case urlError
    case decodingError
    case unknownError(String)
}
