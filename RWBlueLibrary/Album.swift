//
//  Album.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import Foundation

struct Album {
    let title:String
    let artist:String
    let genre:String
    let coverUrl:String
    let year:String
}

extension Album: CustomStringConvertible {
    var description:String {
        return "title: \(title)" +
            " artist: \(artist)" +
            " genre: \(genre)" +
            " coverUrl: \(coverUrl)" +
            " year: \(year)"
    }
}
