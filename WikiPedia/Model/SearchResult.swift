//
//  SearchResult.swift
//  WikiPedia
//
//  Created by Magna on 28/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.

import UIKit
struct SearchResult : Decodable {
    let batchcomplete : Bool?
    let `continue` : ContinueSet?
    let query :QuerySet?
}
struct ContinueSet: Decodable {
    let gpsoffset : Int?
    let `continue` : String?
}
struct QuerySet : Decodable {
    let redirects :[RedirectSet]?
    let  pages : [PagesSet]
    struct RedirectSet : Decodable {
        let index : Int?
        let from : String?
        let to     : String?
    }
}
struct PagesSet : Decodable {
    let pageid : Int?
    let ns        :Int?
    let title    : String?
    let index : Int?
    let thumbnail :ThumbnailSet?
    let terms : TermsSet?
    struct ThumbnailSet : Decodable  {
        let source : String?
        let width : Int?
        let height :Int?
    }
    struct TermsSet  : Decodable {
        let description : [String]?
    }
}


