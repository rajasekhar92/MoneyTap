//
//  Database.swift
//  WikiPedia
//
//  Created by Magna on 29/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.
//
import UIKit
import CoreData
class Database: NSObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
func insertSearchResults(data : PagesSet){
        let managedContext = appDelegate.persistentContainer.viewContext
        let pageRes = NSEntityDescription.insertNewObject(forEntityName: "SearchData", into: managedContext) as! SearchData
        pageRes.title = data.title
        pageRes.descri =  "\(data.terms?.description ?? [""])"
        pageRes.source = data.thumbnail?.source
        if let index = data.index{
            pageRes.index = Int32(index)
        }
        if let ns = data.index{
            pageRes.ns = Int32(ns)
        }
        if let pageid = data.index{
            pageRes.pageid = Int32(pageid)
       }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
