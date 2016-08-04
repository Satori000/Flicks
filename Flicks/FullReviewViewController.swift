//
//  FullReviewViewController.swift
//  Flicks
//
//  Created by Shakeeb Majid on 8/4/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class FullReviewViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var review: NSDictionary?
    
    var movie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        let posterPath = movie!["poster_path"] as? String
        infoView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        
        let highResBaseUrl = "https://image.tmdb.org/t/p/original"
        let lowResBaseUrl = "https://image.tmdb.org/t/p/w45"
        
        authorLabel.text = review!["author"] as! String
        contentLabel.text = review!["content"] as! String
        
        if posterPath != nil {
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
            
            
            
            
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("hello")
        if scrollView == self.scrollView {
            let proportionalOffset = (scrollView.contentOffset.y / 1000)
            print("height: \(scrollView.contentSize.height)")
            print("offset: \(scrollView.contentOffset.y)")
            print("proportional offset: \(proportionalOffset)")
            infoView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5 + proportionalOffset)
            
        }
        print("alpha: \(infoView.alpha)")
        
        //let topConstraint = NSLayoutConstraint(item: infoView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 189 - //scrollView.contentOffset.consta)
        
        // view.addConstraint(horizontalConstraint)
        
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
