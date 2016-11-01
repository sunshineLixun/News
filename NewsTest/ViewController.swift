//
//  ViewController.swift
//  NewsTest
//
//  Created by lixun on 2016/10/16.
//  Copyright © 2016年 sunshine. All rights reserved.
//

import UIKit
//import SwiftyJSON

class NewsModel: NSObject {
    
    var title: String = ""
    var info: String = ""

}


class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    var jsonArray: NSMutableArray = []
    
    var model: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        DispatchQueue.global().async {
            let filePath: String? = Bundle.main.path(forResource: "news_list", ofType: "json")
            if let path = filePath {
                let url  = URL.init(fileURLWithPath: path)
                do {
                    let data = try Data.init(contentsOf: url)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                        
                        let jsonData = json["news_list"] as! NSArray
                        
//                        print(jsonData)
                      
                        for element in jsonData
                        {
                            self.model = NewsModel.init()
                            let dic = element as! NSDictionary
                            if (dic["news_title"] as? String) != nil,dic["intro"] as? String != nil {
                                self.model.title = (dic["news_title"] as? String)!
                                self.model.info = (dic["intro"] as? String)!
                                self.jsonArray.add(self.model)
                            }
                           
                            print(self.jsonArray.count,self.model.title,self.model.info)
                        }
                   
                    } catch  {
                        print("json: \(error)")
                    }
                    
//                    let json = JSON.init(data: data, options: .allowFragments, error: nil)
//                    print(json)
                } catch {
                    print("data:\(error)")
                }
            }
        }
        
        DispatchQueue.main.async(execute:{
            self.tableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    //MARK:dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.content.numberOfLines = 1;
        let model: NewsModel = self.jsonArray[indexPath.row] as! NewsModel
        cell.model = model
        cell.updateImageHeight()
        return cell
    }
    
    //MARK: delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        tableView.beginUpdates()
        cell.content.numberOfLines = cell.content.numberOfLines == 0 ? 1:0
        cell.updateImageHeight()
        tableView.endUpdates()
        
    }
}

