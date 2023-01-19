//
//  DetailViewController.swift
//  News
//
//  Created by Zahraa Zuhaier L on 27/01/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // check that there is a url
        if articleUrl != nil {
            
            // create the url object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                //Couldn't create the url object
                return
            }
            
            // Create the URLRequest object
            
            let request = URLRequest(url: url!)
            
            // Start Spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
            // Load it in the webview
            
            webView.load(request)
        }
        
        
    }
}

extension DetailViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Stop the spinner and hide it
        
        spinner.stopAnimating()
        spinner.alpha = 0
    }
    
}
