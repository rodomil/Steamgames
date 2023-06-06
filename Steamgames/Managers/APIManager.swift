//
//  APIManager.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.

import UIKit

enum MedodReadData: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

final class APIManager {
    
    static func getDataFromServer(metod: MedodReadData, url: String, inputData: [String: Any]?, completionHandler: @escaping (Data?) -> Void) {

        let urlF = (url).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        print(urlF)
        guard let urlN = URL(string: urlF) else {
            completionHandler(nil)
            return
        }
        var request = URLRequest(url: urlN)
        request.httpMethod = metod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        if let data = inputData {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed) else { return }
            request.httpBody = httpBody
            print(httpBody)
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status request - \(response.statusCode)")
            }
            completionHandler(data)
            
            }.resume()
    }
    
    //-----

    
    static func loadDataGET<T: Decodable>(structData: T.Type, url: String, inputData: [String: Any]?, completionHandler: @escaping (T?) -> Void) {
        APIManager.getDataFromServer(metod: .GET, url: url, inputData: inputData) { (data) in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let json = try JSONDecoder().decode(structData.self, from: data)
                        completionHandler(json)
                    } catch {
                        print(error)
                        completionHandler(nil)
                    }
                }
            } else {
                completionHandler(nil)
            }
        }
    }
    

}
