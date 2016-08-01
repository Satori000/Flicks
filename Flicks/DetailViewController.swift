//
//  DetailViewController.swift
//  Flicks
//
//  Created by Shakeeb Majid on 1/18/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoView: UIView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        //scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 4)

        
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as? String
        let highResBaseUrl = "https://image.tmdb.org/t/p/original"
        let lowResBaseUrl = "https://image.tmdb.org/t/p/w45"
        let smallImageRequest = NSURLRequest(URL: NSURL(string: lowResBaseUrl + posterPath!)!)
        let largeImageRequest = NSURLRequest(URL: NSURL(string: highResBaseUrl + posterPath!)!)
        
        self.posterView.setImageWithURLRequest(
            smallImageRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                
                // smallImageResponse will be nil if the smallImage is already available
                // in cache (might want to do something smarter in that case).
                self.posterView.alpha = 0.0
                self.posterView.image = smallImage;
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.posterView.alpha = 1.0
                    
                    }, completion: { (sucess) -> Void in
                        
                        // The AFNetworking ImageView Category only allows one request to be sent at a time
                        // per ImageView. This code must be in the completion block.
                        self.posterView.setImageWithURLRequest(
                            largeImageRequest,
                            placeholderImage: smallImage,
                            success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                
                                self.posterView.image = largeImage;
                                
                            },
                            failure: { (request, response, error) -> Void in
                                // do something for the failure condition of the large image request
                                // possibly setting the ImageView's image to a default image
                        })
                })
            },
            failure: { (request, response, error) -> Void in
                // do something for the failure condition
                // possibly try to get the large image
        })
        
 
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 4)

        
        
        
        
        
        /*let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
        let highResBaseUrl = "https://image.tmdb.org/t/p/original"
        let lowResBaseUrl = "https://image.tmdb.org/t/p/w45"
        
        
        if let posterPath = movie["poster_path"] as? String {
            var posterURL = NSURL(string: lowResBaseUrl + posterPath)
            posterView.setImageWithURL(posterURL!)
            
        } */
        
        
        
        titleLabel.text = title
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        

        //posterView.setImageWithURL(NSURL(string: "https://image.tmdb.org/t/p/original")!)

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("hello")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
