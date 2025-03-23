//
//  NetworkService.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation

final class NetworkService: Sendable {
    
    static let sessionManager: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30 // seconds
        return URLSession(configuration: configuration)
    }()
    
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String] = [:],
        body: Data? = nil
    ) async throws -> T {
        let request = try buildRequest(url: url, method: method, headers: headers, body: body)
        return try await performRequest(request)
    }
    
    // Specialized convenience methods
    func get<T: Decodable>(url: URL, headers: [String: String] = [:]) async throws -> T {
        return try await request(url: url, method: .get, headers: headers)
    }
    
    func post<T: Decodable>(url: URL, body: Data, headers: [String: String] = [:]) async throws -> T {
        return try await request(url: url, method: .post, headers: headers, body: body)
    }
}
    
//MARK: -  // Private helpers
private extension NetworkService{
        
    private func buildRequest(url: URL, method: HTTPMethod, headers: [String: String], body: Data?) throws -> URLRequest {
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
                request.httpBody = body
            } else if body != nil && method == .get {
                throw NetworkError.bodyNotAllowedForMethod(method)
            }
            request.httpMethod = method.rawValue
            return request
            
        }
        
        private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
            let (data, response) = try await NetworkService.sessionManager.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299: // Success codes (2xx)
                    return data as! T // Proceed with the data
                case 400...499: // Client errors
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

