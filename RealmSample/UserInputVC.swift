//
//  ViewController.swift
//  RealmSample
//
//  Created by pyngit on 2015/10/22.

import UIKit


class UserInputVC: UIViewController ,UIPickerViewDelegate {
    /* 画面内定数 */
    let MONTH_LIST = ["1","2","3","4","5","6","7","8","9","10","11","12"];
    let DAY_LIST = ["01","02","03","04","05","06","07","08","09","10"
                        ,"11","12","13","14","15","16","17","18","19","20"
                        ,"21","22","23","24","25","26","27","28","29","30","31"]
    
    /* 画面内UI */
    //名前のフィールド
    @IBOutlet var nameTextField: UITextField!
    
    //誕生日のフィールド
    @IBOutlet var birthDayPicer: UIPickerView!
    
    /* クラス内メンバ変数 */
    //選択した日付
    var selectMonthIndex:Int = 0;
    var selectDayIndex:Int = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserInputVC viewDidLoad start.");
        
        //開始時に全件削除
        do{
            let service = UserService();
            try service.deleteAll();
        }catch let error as NSError {
            print("error :\(error)");
        }
        print("UserInputVC viewDidLoad end.");

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
     送信ボタン押下
     
     */
    @IBAction func onSubmit(sender: UIButton) {
        print("onSubmit \(sender)");
        
        print("名前：\(nameTextField.text)");
        
        
        selectMonthIndex = birthDayPicer.selectedRowInComponent(0);
        selectDayIndex = birthDayPicer.selectedRowInComponent(1);
        let birthDayStr:String = MONTH_LIST[selectMonthIndex] + DAY_LIST[selectDayIndex];
        
        do{
            //名前の必須チェック
            if(nameTextField.text != ""){
                print("誕生日：\(Int.init(birthDayStr))");
                
                let user = UserDomain();
                user.name = nameTextField.text!;
                user.birthday = Int.init(birthDayStr)!;

                let service = UserService();
                try service.add(user);
                
                let vo:UserInfoVO = UserInfoVO();
                vo.userDomain = user;
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main" , bundle: NSBundle.mainBundle())
                // 遷移するViewを定義する.
                let userResultVC: UserResultVC = storyboard.instantiateViewControllerWithIdentifier("userResult") as! UserResultVC;
                
                //次画面に情報を渡す。
                userResultVC.userInfoVO = vo;
                
                // アニメーションを設定する.
                userResultVC.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
                
                // Viewの移動する.
                self.presentViewController(userResultVC, animated: true, completion: nil)
            }else{
                //必須エラー
                popUpAlert("名前は必須入力です。");
            }
            
        }catch let error as NSError{
            print("error:\(error)");
        }
        
    }
    /**
     アラート表示
     - parameter String: アラートメッセージ
    */
    private func popUpAlert(alertMsg:String){
        //アラート表示
        let alertController = UIAlertController(title: "エラー", message: alertMsg, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }

    
    //UI Picer用設定
    //表示列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if(component == 0){
    		return MONTH_LIST.count;  // 1列目の選択肢の数
 	 	}else{
    		return DAY_LIST.count;  // 2列目の選択肢の数
  		}
	}
 
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if(component == 0){
    		return MONTH_LIST[row]  // 1列目のrow番目に表示する値
 	 	}else{
    		return DAY_LIST[row]  // 2列目のrow番目に表示する値
  		}
	}
    /*
    pickerが選択された際に呼ばれるデリゲートメソッド.
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
        }else{
        }
    }
    
}

