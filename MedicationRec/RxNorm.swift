//
//  RxNorm.swift
//  MedicationRec
//
//  Created by Ryan Padden on 11/12/18.
//  Copyright © 2018 Ryan Padden. All rights reserved.
//

import Foundation

//open func dataTask(with request: URLRequest,
//                   completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void
//    ) -> URLSessionDataTask{
//
//}



//
//struct Wrapper : Decodable {
//    let drugName : DrugName
//    enum CodingKeys: String, CodingKey{case drugName = "result"}
//}
//
//struct DrugName: Codable, CustomDebugStringConvertible{
//    let name : String
//
//    static func endpointForCode(_ code: String) -> String{
//        return "https://rxnav.nlm.nih.gov/REST/drugs.json?name=\(code))"
//    }
//
//    var debugDescription: String{
//        return "\(name)"
//
//    }
//
//
//}
//
//class DrugNameService
//{
//    static let shared = DrugNameService()
//
//    fileprivate init(){}
//
//    func lookupDrugName(code:String, completionHandler: (@escaping (DrugName?, RESTError?) -> Void)) {
//        // Need to escape the space in postal codes
//        guard let escapedCode = code.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else
//        {
//            let error = RESTError.couldNotEscape
//            completionHandler(nil, error)
//            return
//        }
//        // get the endpoint with the postal code to search for
//        let codeEndpoint = DrugName.endpointForCode(escapedCode)
//        guard let codeURL = URL(string: codeEndpoint) else {
//            let error = RESTError.badURL
//            completionHandler(nil, error)
//            return
//        }
//        // Create the URLRequest with the above URL
//        var urlRequest = URLRequest(url: codeURL)
//        urlRequest.httpMethod = "GET"
//
//        // Create task that retrieves the contents of a URL, and calls handler upon completion.
//        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
//            (data, response, error) in
//            let decoder = JSONDecoder()
//
//            // Check for error
//            guard error == nil else {
//                completionHandler(nil, RESTError.requestFailed)
//                return
//            }
//            // Get the response data
//            guard let responseData = data else {
//                let error = RESTError.invalidData
//                completionHandler(nil, error)
//                return
//            }
//
//            // Get the HTTP Response metadata so we can check the status code
//            // Based on status code, we know whether to decode a DrugNameCode or ErrorJson object
//
//
//    /*
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completionHandler(nil, RESTError.invalidResponse)
//                return
//            }
//            //if httpResponse.statusCode == 200 {
//                // Status code 200 means we expect a DrugName based on REST API Docs
//             */
//             do {
//                    let decoder = JSONDecoder()
//
//                    let wrapper = try decoder.decode(Wrapper.self, from: responseData)
//                    let foundCode = wrapper.drugName
//
//                    completionHandler(foundCode, nil)
//                } catch {
//                    // Something went wrong in the decoding
//                    // Note: could also expand this to catch the defined DecondingError enum cases (see Apple Docs)
//                    completionHandler(nil, RESTError.jsonParsingFailure)
//                }
//            /*
//            //}
//            else
//            {
//
//                // Status code other than 200 means we expect an ErrorJson based on REST API Docs
//                do {
//                    let errorJson = try decoder.decode(ErrorJson.self, from: responseData)
//                    // Here we can use the message from the ErrorJson to build our RESTError
//                    completionHandler(nil, RESTError.custom(message: errorJson.error))
//                } catch {
//                    completionHandler(nil, RESTError.jsonParsingFailure)
//                }
//
//            }
//
// */
//        })
//        task.resume()
//    }
//}
