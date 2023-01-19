//
//  ArticleModel.swift
//  News
//
//  Created by Zahraa Zuhaier L on 26/01/2021.
//

import Foundation

protocol ArticleModelProtoccol {
    
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtoccol?
    var articles:[Article]?

    func getArticles() {
        
        // Fire off the request to the API
        
        // Create url String
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4e5cbc83306c437381defd47453dbe5f"
        
        
        // Create URL object
        let url = URL(string: urlString)
        
        // check it isn't nill
        guard url != nil else {
            
            print("Couldn't create url object")
            return
        }
        
        // Get the URL session
        let session = URLSession.shared
        
        // Create Data Task
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // check if there are no errors and that there is data
            
            if error == nil && data != nil {
                
                // Attempt tp parse the JSON
                
                let decoder = JSONDecoder()
                
                do{
                    // Parse the JSON into ArticleService
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Get the articles
                   
                    self.articles = articleService.articles
                   

                    
                    // pass it back to the view controller in the main thread
                    DispatchQueue.main.async {
                        if self.articles != nil {
                        self.delegate?.articlesRetrieved(self.articles!)
                       
                        }
                        else {
                            print("error: there is no article to show")
                        }
                    }
                }
                catch {
                    print ("Error Parsing the JSON")
                } // End DO - Catch
                
            } // End if
        } // End Data Task
        
        // Start the Data Task
        dataTask.resume()
        
    }
}

