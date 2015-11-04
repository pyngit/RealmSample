//
//  UserService.swift
//  RealmSample
//
//  Created by pyngit on 2015/10/29.
//
//

import Foundation

class UserService{
    /**
     ユーザ情報の取得
     
    - parameter UserDomain: 取得するユーザのIDをセットしたUserDomain
    */
    func getUserInfo(userDomain:UserDomain) throws -> UserInfoVO{
        print("getUserInfo user id:\(userDomain.id)");
        let vo = UserInfoVO();

        let userRealm = CommonRealm.createRealm();
        
        //ユーザ情報の取得
        let userResult:UserDomain? = userRealm.objectForPrimaryKey(UserDomain.self, key: userDomain.id);
        
        //誕生日から星座を取得
        if(userResult != nil){
            //検索結果をセット
            vo.userDomain = userResult!;
            
            //ユーザ情報から星座を取得
            let birthday = userResult!.birthday;
            let masterRealm = CommonRealm.createRealm("master");
            let singsZodiacList = masterRealm.objects(SingsZodiacDomain).filter("mindate <= \(birthday) AND maxdate >= \(birthday)")
            
            print("singsZodiacList count:\(singsZodiacList.count)");
            if(singsZodiacList.count > 0){
                vo.signsZodiacDomain = singsZodiacList[0];
            }
        }
        
        return vo;
    }
    /*
    ユーザ登録
    - parameter UserDomain: 登録するUserDomain
    */
    func add(userDomain:UserDomain) throws ->UserInfoVO{
        let vo = UserInfoVO();
        vo.userDomain = userDomain;
        
        let realm = CommonRealm.createRealm();
        
        //IDのセット
        let userId:Int? = realm.objects(UserDomain).max("id");
        
        print("UserService add userId:\(userId)");
        if(userId != nil){
            //ID に一つ加算
            userDomain.id = userId! + 1;
        }else{
            userDomain.id = 0;
        }
        realm.beginWrite()
        
        //追記
        realm.add(userDomain);
        
        try realm.commitWrite();
        
        print("UserService add:\(userDomain.id) - \(userDomain.name) - \(userDomain.birthday))");
        
        return vo;
    }
    /**
     全件削除
    */
    func deleteAll()throws{
        let realm = CommonRealm.createRealm();
        //全件取得
        let allObject = realm.objects(UserDomain);
        print("deleteAll count:\(allObject.count)");
        
        if(allObject.count > 0){
            realm.beginWrite()
            //検索結果を削除
            realm.delete(allObject);
            try realm.commitWrite();
        }
    }

}