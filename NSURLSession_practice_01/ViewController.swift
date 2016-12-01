//
//  ViewController.swift
//  NSURLSession_practice_01
//
//  Created by yuichi.watanabe on 2016/12/01.
//  Copyright © 2016年 yuuichi.watanabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var someList : [(maker:String, name:String, url:String, image:String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        sessionNo4()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    // ----------------------------------------------------------------
    // MARK: - fileprivate
    
    
    /** GET HTTP Request (非同期) */
    fileprivate func sessionNo1()
    {
        let url             = NSURL(string: "https://www.google.co.jp/")
        let config          = URLSessionConfiguration.default
        let session         = URLSession(configuration: config)
        
        let req             = NSURLRequest(url: url as! URL )
        let task            = session.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
            print(resp?.url! as Any)
            print(data)
        })
        task.resume()
    }
    
    
    /** POST HTTP Request */
    fileprivate func sessionNo2()
    {
        let url             = NSURL(string: "http://localhost:1234/")
        let config          = URLSessionConfiguration.default
        let session         = URLSession(configuration: config)
        
        let req             = NSMutableURLRequest(url: url as! URL)
            req.httpMethod  = "POST"
            req.httpBody    = "id=13&name=Jack".data(using: String.Encoding.utf8)
        
//        let task            = session.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
//            print( resp?.url! as Any)
//            print( data )
//        })
//            task.resume()
        
        session.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
            print( resp?.url! as Any)
            print( data )
        }).resume()
        
        NSLog("aa")
    }
    
    
    
//    /** JSON POST HTTP Request */
//    fileprivate func sessionNo31()
//    {
//        let config          = URLSessionConfiguration.default
//        let session         = URLSession(configuration: config)
//        
//        var url             = NSURL(string: "http://localhost:1234/")
//        let params:[String: Any] = [
//            "email"     : "aaaa@bbb.cc.dd",
//            "userPwd"   : "bbbb",
//            "a"         : true
//        ]
//
//        var json : String
//        
//        do {
//            let jsondata : Data = try JSONSerialization.data(withJSONObject: params, options:nil) else {
//                print(jsondata)
//        }
//        catch {
//            print("error trying to convert data to JSON")
//            return
//        }
//            
//
//    }
    
    /** JSON POST HTTP Request */
    fileprivate func sessionNo3()
    {
//        let config          = URLSessionConfiguration.default
//        let session         = URLSession(configuration: config)
//        
//        var url             = NSURL(string: "http://localhost:1234/")
//        let params:[String: Any] = [ "email" : "aaaa" as Any, "userPwd" : "bbbb" as Any ]
//            
//        var err: NSError?
//        var req = NSMutableURLRequest(url: url! as URL)
//            req.setValue("application/json; charaset=utf-8", forHTTPHeaderField: "Content-Type")
//            req.httpMethod  = "POST"
//            req.httpBody    = JSONSerialization.dataWithJSONObject(params, options: JSONSerialization.WritingOptions.allZeros, error: &err)
//        
//            //req.httpBody = JSONSerialization.data(withJSONObject: params, options: JSONSerialization.ReadingOptions.mutableContainers)
//        
//        
//        let task = session.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
//            print(resp?.url! as Any)
//            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
//        })
//            
//        task.resume()
    }
    
    
    
    fileprivate func sessionNo5()
    {
        // これは、
        let url             = NSURL(string: "https://www.google.co.jp/")
        let config          = URLSessionConfiguration.default
        let session         = URLSession(configuration: config)
        
        let req             = NSURLRequest(url: url as! URL )
        let task            = session.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
            print(resp?.url! as Any)
            print(data)
        })
        task.resume()
    }
    
    fileprivate func sessionNo4()
    {
        // https -> httpにするとエラーが発生します。
        // let listUrlString   =  "https://www.yahoo.co.jp" -> [42] Protocol not available 利用できない "s"ない
        // let listUrlString   = "https://www.google.co.jp/" -> JSONでないので Error Domain=NSCocoaErrorDomain
        //                          --> catchへ
        
        // http://www.jsontest.com/ ここでJSON受け取れるけど、httpsでないのでダメだ、、、targetのiOS Verを落として試そう
        
        let url                 = URL(string: "http://headers.jsontest.com/")
        let request             = NSMutableURLRequest(url: url!)
            request.httpMethod  = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                DispatchQueue.main.sync(execute: {
                    //AWLoader.hide()
                })
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any]
                
                if let parseJSON = json {
                    
                    print ("sessionNo4 \(parseJSON)")
                    //var items = self.categoryList
                        //items.append(contentsOf: parseJSON as! [String])
                    
                    //if self.fromIndex < items.count {
                        //self.categoryList = items
                        //self.fromIndex = items.count
                        
                        //DispatchQueue.main.async(execute: {
                            //self.categoriesTableView.reloadData()
                            //AWLoader.hide()
                        //})
                    //}
                    //else if( self.fromIndex == items.count){
                        //DispatchQueue.main.async(execute: {
                            //AWLoader.hide()
                        //})
                    //}
                }
                

                // 例えば、、値を取り出して保持するとか
                if let items = json?["item"] as? [[String: Any]] {
                    
                    for item in items {
                        
                        guard let maker = item["maker"] as? String else {
                            continue
                        }
                        
                        guard let name = item["name"] as? String else {
                            continue
                        }
                        
                        guard let link = item["url"] as? String else {
                            continue
                        }
                        
                        guard let image = item["image"] as? String else {
                            continue
                        }
                        
                        let okashi = (maker,name,link,image)
                        
                        self.someList.append(okashi)
                    }
                    
                    //self.tableview.reloadData() //TableViewを更新する
                }
                
            }
                
            catch {
                //AWLoader.hide()
                print(error)
                
            }
            
        }).resume()

    }
    

}

