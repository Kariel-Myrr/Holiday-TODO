//
//  DataLayer.swift
//  DataLayerForToDoHoliday
//
//  Created by Kariel Myrr on 28.01.2021.
//

import Foundation
import Combine

class DataLayer {
    
    typealias Completion = (Any) -> Void
    
    var queue : OperationQueue
    
    
    var urlRequest : URLRequest
    var session : URLSession
    
    init() {
        
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2;
        
        //Network config
        let config = URLSessionConfiguration.default

        session = URLSession(configuration: config)

        let url = URL(string: "https://holidaytodo.herokuapp.com/hw")!
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
    }
    
    func pushData(session : URLSession, urlRequest : URLRequest, completion : @escaping Completion){
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            print("gotten json response dictionary is \n \(json)")
            
            OperationQueue.main.addOperation {
                print("aa")
                completion(json)
            }
            // update UI using the response here
        }

        // execute the HTTP request
        task.resume()
        
    }
    
    // postDict format: { "day" : day, "timeManagment" : { "time" : *task* }, "options" :  {any}}
    // task : { "text" : text, "options" : options }
    func pushDataDay(postDict : [String : Any], completion : @escaping (Any) -> Void){
        // your post request data
        //postDict : [String: Any] = ["name": "axel", "favorite_animal": "fox"]

        
        //TODO: check format
        
        
        guard let postData = try? JSONSerialization.data(withJSONObject: postDict, options: []) else {
            return
        }

        urlRequest.httpBody = postData
        
        pushData(session: session, urlRequest: urlRequest, completion: completion)
    }
    
    func getData(){
        
        
    }
}


