//
//  ContentTableModel.swift
//  MJianshu
//
//  Created by wjl on 15/12/26.
//  Copyright © 2015年 Martin. All rights reserved.
//

import Foundation

class Article: NSObject {    
    var userName: String?
    var articleTitle: String?
    var previewImageStr: String?
    var timeValue: String?
    var readNumber: NSNumber?
    var commentNumber: NSNumber?
    var favorNumber: NSNumber?
    
}
// 这里等加了本地数据之后再改吧，晕乎乎的还不知道这里可以做啥
protocol Repository{
    var pageID: Int? { get }
    func loadArticles(pageID: Int)->[Article]
}

class ArticleRepository: Repository {
    
    var pageID: Int?
    var articleArray: NSArray?
    var emptyResult: NSArray = []
    
    // 使用Leancloud来存储数据－获取数据
    func loadArticles(pageID: Int)->[Article] {
        let query = AVQuery(className: "FindContentModel")
        query.whereKey("pageID", equalTo: pageID)
        query.limit = 8
        query.addDescendingOrder("updatedAt")
        let jsonResult = query.findObjects()
        guard jsonResult != nil else{
            return emptyResult as! [Article]
        }
        let jsonArray = jsonResult as NSArray
        articleArray = Article.mj_objectArrayWithKeyValuesArray(jsonArray.valueForKey("localData"))
        return articleArray! as! [Article]
        
    }
}

