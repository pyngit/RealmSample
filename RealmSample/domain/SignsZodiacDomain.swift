//
//  SignsZodiacDomain.swift
//  RealmSample
//
//  Created by pyngit on 2015/10/22.
//

import Foundation
import RealmSwift
/**
 星座情報データのドメイン
*/
class SingsZodiacDomain:Object{
    // id
    dynamic var id = "";
    //　星座名
    dynamic var name = "";
    //　開始日
    dynamic var mindate = 0;
    //　終了日
    dynamic var maxdate = 0;
    override static func primaryKey() -> String? {
        return "id"
    }
}