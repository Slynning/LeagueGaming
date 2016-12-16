//
//  HttpRequestLeague.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 24/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class HttpRequestLeague: NSObject {
    let apiKey = "?api_key=RGAPI-9d647281-cb1e-4d46-8dc6-b0b1e4fef02f"
    
    func getDataFromServeur (url: String) -> Data {
        let urlRequest = url + apiKey
        var dataInvocateur = Data()
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlRequest);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            if(responseString != nil) {
                print("responseString = \(responseString)")
            }
            dataInvocateur = data!
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return dataInvocateur
    }
}









