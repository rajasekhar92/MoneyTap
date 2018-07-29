//
//  Keys.swift
//  WikiPedia
//
//  Created by Magna on 28/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.
//

import Foundation
import UIKit

public struct Keys {
    static let BASEURL = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description"
    static let GpsSearch = "gpssearch"
    static let GpsLimit  = "gpslimit"
}
