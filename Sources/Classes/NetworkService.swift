//
//  NetworkService.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation
//import FoundationNetworking
actor NetworkService{
    
    static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Customize as needed
        configuration.timeoutIntervalForResource = 30
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    // Alternative: Configurable singleton with more flexibility
    private static var customSession: URLSession?
    
    static func setCustomSession(_ session: URLSession) {
        customSession = session
    }
    
    // Use either the custom or default session
    private var urlSession: URLSession {
        return Self.customSession ?? Self.session
    }
    
    // No need to pass session in init anymore
    init() {}
    
    func request(
        url: URL,
        method: HTTPMethod,
        headers: [String: String] = [:],
        payload: Data? = nil
    ) async throws -> Data {
        let request = try buildRequest(url: url, method: method, headers: headers, payload: payload)
        return try await performRequest(request)
    }
    
    // Specialized convenience methods
    func get(url: URL, headers: [String: String] = [:]) async throws -> Data {
        return try await request(url: url, method: .get, headers: headers)
    }
    
    func post(url: URL, payload: Data, headers: [String: String] = [:]) async throws -> Data {
        return try await request(url: url, method: .post, headers: headers, payload: payload)
    }
}
    
//MARK: -  // Private helpers
private extension NetworkService{
        
    private func buildRequest(url: URL, method: HTTPMethod, headers: [String: String], payload: Data?) throws -> URLRequest {
            var request = URLRequest(url: url)
            // standard headers
            for (key, value) in DefaultRequest.headers{
                request.setValue(value, forHTTPHeaderField: key)
            }
            //custom header
            for (key, value) in headers{
                request.setValue(value, forHTTPHeaderField: key)
            }
            if method != .get && method != .delete {
                request.httpBody = payload
            } else if payload != nil && method == .get {
                throw NetworkError.bodyNotAllowedForMethod(method)
            }
            request.httpMethod = method.rawValue
            return request
            
        }
        
    private func performRequest(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299: // Success codes (2xx)
                    return data // Proceed with the data
                case 400...499: // Client errors //TODO: HANDLE ERRORS
                    throw NetworkError.clientError(statusCode: httpResponse.statusCode, data: data)
                    
                case 500...599: // Server errors
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                    
                default:
                    throw NetworkError.unexpectedStatusCode(httpResponse.statusCode)
                }
            }
            throw NetworkError.unexpectedResponseType
        }
    }

