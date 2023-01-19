//
//  ArticleCell.swift
//  News
//
//  Created by Zahraa Zuhaier L on 28/01/2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    
    func displayArticle(_ article:Article){
        
        // Clean up the cell before displaying the next article
        
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        
        // Keep a refrence to the article
        
        articleToDisplay  = article
        
        
        // Set the headline
        
        headlineLabel.text = articleToDisplay!.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.headlineLabel.alpha = 1
        }, completion: nil)
        
        
        // Download and display the image
        
        // check that the artice actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Get Url String
        let urlString = articleToDisplay!.urlToImage!
        
        // check the CacheManager before downloading any image data
        
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // there is image data . set the imageview and return
            
            articleImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImageView.alpha = 1
            }, completion: nil)
            
            return
        }
        
        // Create url
        let url = URL(string: urlString)
        
        // Check if url is not nil
        guard url != nil else {
            return
        }
        
        // Get a URLSession
        
        let urlSesstion = URLSession.shared
        
        // Create DataTask
        
        let dataTask = urlSesstion.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data into cache
                CacheManager.SaveData(urlString, data!)
                
                
                // check if the url string that the data task went off to download matches the artice this cell is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    DispatchQueue.main.async {
                        
                        // Display the image data in the image view
                        
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            self.articleImageView.alpha = 1
                        }, completion: nil)
                        
                        
                    }
                }
            }
        }
        // Kik off the datatask
        dataTask.resume()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
