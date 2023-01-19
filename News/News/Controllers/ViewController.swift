//
//  ViewController.swift
//  News
//
//  Created by Zahraa Zuhaier L on 26/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        model.delegate = self
        
        // Get the articles from the article model
        model.getArticles()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the index path the user selected
        let indexPath = tabelView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            // the user hasn't selected anything
            return
        }
        
        // Get the article
        
        let article = articles[indexPath!.row]
        
        // Get a refrence to the detail view contrller
        let detailVC = segue.destination as! DetailViewController
        
        // pass the article url to the detail view controller
        detailVC.articleUrl = article.url!
    }
}




// Mark: -TabelView Delegate and DataSource methods
extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell" , for: indexPath) as! ArticleCell
        
        
        // Get the Article
        let article = articles[indexPath.row]
        
        
        // Customize the cell
        cell.displayArticle(article)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // User just selected a row , trigger the segue to go to detail
        performSegue(withIdentifier: "goToDetailVC", sender: self)
        
    }
    
}



// MARK: -ArticleModelProtocols Methods
extension ViewController : ArticleModelProtoccol {
    
    
    func articlesRetrieved(_ articles: [Article]) {
        
        // set the articles property of the view controller to the articles passed from the model
        self.articles = articles
        
        // Refresh the tabelView
        tabelView.reloadData()
    }
    
    
    
}

