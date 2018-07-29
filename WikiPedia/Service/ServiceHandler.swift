//
//  ServiceHandler.swift
//  WikiPedia
//
//  Created by Magna on 28/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.
//

import UIKit
import Foundation
class ServiceHandler{
    static let sharedInstance = ServiceHandler()
    init() {
    }
  public  func fetchFeaturedApps(_ urlStr:String, _ completionHandler: @escaping (SearchResult) -> ()) {
    URLSession.shared.dataTask(with: URL(string: urlStr)!, completionHandler: { (data, response, error) -> Void in
            guard let data = data else { return }
            if let error = error {
                print(error)
                return
        }
            do {
                let decoder = JSONDecoder()
                let serachJsonData = try decoder.decode(SearchResult.self, from: data)
                print(serachJsonData)
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(serachJsonData)
                })
            } catch let err {
                print(err)
            }
        }) .resume()
    }
}
