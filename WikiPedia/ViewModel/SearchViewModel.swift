//
//  SearchViewModel.swift
//  WikiPedia
//
//  Created by Magna on 28/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.
//
import UIKit
import SDWebImage
struct SearchViewModel {
    let tittle: String?
    let description: [String]?
    var  imgsourceUrl :String?
    init(page:PagesSet) {
        self.tittle = page.title!
        self.description = page.terms?.description
        self.imgsourceUrl = page.thumbnail?.source
    }
}
