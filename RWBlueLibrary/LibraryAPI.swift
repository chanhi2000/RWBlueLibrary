//
//  LibraryAPI.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import Foundation

final class LibraryAPI {
    
    // to give other objects access to it
    static let shared = LibraryAPI()
    
    // to prvent creating another new instance outside.
    private init() {
        
    }
}
