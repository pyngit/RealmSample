//
//  UserResultVC.swift
//  RealmSample
//
//  Created by pyngit on 2015/10/29.
//
//

import UIKit

class UserResultVC: UIViewController {

    /* 画面内UI */
    //名前
    @IBOutlet var nameLabel: UILabel!;
    //誕生日
    @IBOutlet var birthdayLabel: UILabel!;
    //星座
    @IBOutlet var zodiacLabel: UILabel!;
    
    /* クラス内メンバ変数 */
    var userInfoVO:UserInfoVO?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad start.");
        
        
        //
        do{
            let service = UserService();
            
            if(userInfoVO?.userDomain != nil){
                //ユーザ情報を取得
                userInfoVO = try service.getUserInfo(userInfoVO!.userDomain);
                
                
                if(userInfoVO != nil){
                    nameLabel.text = userInfoVO!.userDomain.name;
                    let birthdayStr:String = String(userInfoVO!.userDomain.birthday);
                    
                    var monthIdx = birthdayStr.endIndex;
                    monthIdx = monthIdx.advancedBy(-2);
                    
                    let birthdayLblStr = birthdayStr.substringToIndex(monthIdx) + "月"
                        + birthdayStr.substringFromIndex(monthIdx) + "日";
                    
                    print("\(birthdayLblStr)");
                    
                    birthdayLabel.text = birthdayLblStr;
                    zodiacLabel.text = userInfoVO!.signsZodiacDomain.name;
                }else{
                    //取得できなかった場合は空をセット
                    nameLabel.text = "";
                    birthdayLabel.text = "";
                    zodiacLabel.text = "";
                    
                }
            }
            
        }catch let error as NSError{
            print("error message:\(error)");
        }
        
        print("viewDidLoad end.");
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
