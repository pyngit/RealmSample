//
//  CommonRealm.swift
//  RealmSample
//
//  Created by pyngit on 2015/10/29.
//
//

import Foundation
import RealmSwift

class CommonRealm:Object{
    //マスターデータのアプリケーションバンドルパス
    static let MASTER_DATA_PATH = NSBundle.mainBundle().pathForResource("MasterData", ofType:"realm");
    
    //マスター用のデータ　マスターのバンドルパスを指定して読み込み専用
    static let MASTER_CONFIG = Realm.Configuration(path: MASTER_DATA_PATH,readOnly: true);
    
    /*
    Realmデータを生成
    */
    static func createRealm(kind :String = "user") -> Realm{
//        print("createRealm kind:\(kind) path:\(Realm.Configuration().path)");
        var realm:Realm? = nil;
        do{
            if(kind != "master"){
                realm = try Realm();
            }else{
                realm = try Realm(configuration: MASTER_CONFIG);
            }
        }catch let error as NSError {
            print(" createRealm exception:\(error)");
        }
        return realm!;
    }
    
}