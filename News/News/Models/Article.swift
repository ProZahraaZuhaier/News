//
//  Article.swift
//  News
//
//  Created by Zahraa Zuhaier L on 26/01/2021.
//

import Foundation

struct Article: Decodable{
    
    var author: String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
