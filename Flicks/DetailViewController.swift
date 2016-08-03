//
//  DetailViewController.swift
//  Flicks
//
//  Created by Shakeeb Majid on 1/18/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import YouTubePlayer

class DetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    //@IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var videoCollection: UICollectionView!
    
    var movie: NSDictionary?
    var videos: [NSDictionary]?    

    var videoPlayers: [YouTubePlayerView]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

        videoCollection.delegate = self
        videoCollection.dataSource = self
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 2)

        print("size: \(scrollView.contentSize)")
        
        infoView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        videoCollection.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
     
        print("why aren't you working")
        
        print(screenWidth)

        
        print(movie)
        print(screenWidth)
        print(screenHeight)
        

       
        let title = movie!["title"] as! String

        let overview = movie!["overview"] as! String
        print("before pp")
        let posterPath = movie!["poster_path"] as? String
        print("after pp \(posterPath)")

        let highResBaseUrl = "https://image.tmdb.org/t/p/original"
        let lowResBaseUrl = "https://image.tmdb.org/t/p/w45"

        print("after all")
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
        
        //scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 4)

        print("heyyyyyyy")

        
        
        let id = movie!["id"]!
        print("id: \(id)")
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(apiKey)")
        
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    print("hello why are you working 0")
                    
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                        //NSLog("response: \(responseDictionary)")
                                                                                
                        print(responseDictionary)
                        
                        let results = responseDictionary["results"] as! [NSDictionary]
                        
                        self.videos = results
                        self.videoCollection.reloadData()
                        //let key = results[0]["key"]! as! String
                        print("results: \(results)")
                        //self.videoPlayer.loadVideoID(key)
                        
                        }
                    } else {
                        print("..........nothing shown0")
                                                                            
                    }
        });
        task.resume()
        
        
        
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let videos = videos {
            print("count: \(videos.count)")
            return videos.count
        } else {
            print(0)
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = videoCollection.dequeueReusableCellWithReuseIdentifier("VideoCell", forIndexPath: indexPath) as! VideoCell
        
        let video = videos![indexPath.row]
        let key = video["key"] as! String
        
        cell.videoPlayer.loadVideoID(key)
        
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("hello")
        
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
