//
//  UserDomain.swift
//  RealmSample
//
//  Created by pyngit on 2015/10/29.
//
//

import Foundation
import RealmSwift

/**
ユーザ情報のドメイン
*/
class UserDomain:Object{
    /* ID */
    dynamic var id = 0;
    /* 名前 */
    dynamic var name = "";
    /* 誕生日 1月1日:101　10月23日:1023 */
    dynamic var birthday = 0;
    
    override static func primaryKey() -> String? {
        return "id"
    }

}