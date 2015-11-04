//
//  UserDomain.swift
//  RealmSample
//
//  Created by pyngit on 2015/10/29.
//
//

import Foundation
import RealmSwift

class UserDomain:Object{
    dynamic var id = 0;
    dynamic var name = "";
    dynamic var birthday = 0;
    
    override static func primaryKey() -> String? {
        return "id"
    }

}