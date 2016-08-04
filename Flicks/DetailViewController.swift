
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
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var averageRatingLabel: UILabel!
    
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    //@IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var videoCollection: UICollectionView!
    
    @IBOutlet weak var posterCollection: UICollectionView!
    
    @IBOutlet weak var movieCollection: UICollectionView!
    
    var movie: NSDictionary?
    var videos: [NSDictionary]?
    var images: [NSDictionary]?
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

        videoCollection.delegate = self
        videoCollection.dataSource = self
        
        posterCollection.delegate = self
        posterCollection.dataSource = self
        
        movieCollection.delegate = self
        movieCollection.dataSource = self
        
        //print("movie: \(movie!)")
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 2)
        
        infoView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        videoCollection.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)

       
        let title = movie!["title"] as! String
        let releaseDate = movie!["release_date"] as! String
        print("release date: \(releaseDate)")
        let averageRating = movie!["vote_average"] as! Double
        let ratingCount = movie!["vote_count"] as! Int

        let overview = movie!["overview"] as! String
        let posterPath = movie!["poster_path"] as? String
        

        let highResBaseUrl = "https://image.tmdb.org/t/p/original"
        let lowResBaseUrl = "https://image.tmdb.org/t/p/w45"

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


        
        
        let id = movie!["id"]!
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
                    
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                        //NSLog("response: \(responseDictionary)")
                                                                                
                        //print(responseDictionary)
                        
                        let results = responseDictionary["results"] as! [NSDictionary]
                        
                        self.videos = results
                        self.videoCollection.reloadData()
                        //let key = results[0]["key"]! as! String
                        //print("results: \(results)")
                        //self.videoPlayer.loadVideoID(key)
                        
                        }
                    } else {
                        print("..........nothing shown0")
                                                                            
                    }
        });
        task.resume()
        
        let url1 = NSURL(string:"https://api.themoviedb.org/3/movie/\(id)/images?api_key=\(apiKey)")
       
        let request1 = NSURLRequest(URL: url1!)
        let session1 = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        //print("hellooooo you've approached the second request")
        let task1 : NSURLSessionDataTask = session1.dataTaskWithRequest(request1,
            completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
            print("hello why are you working task 2222222222343242342142431234123412341234124344444!!!!!!!!!!!")
                                                                            
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                data, options:[]) as? NSDictionary {
                //NSLog("response: \(responseDictionary)")
                                                                                
                //print(responseDictionary)
                                                                                
                let backdrops = responseDictionary["backdrops"] as! [NSDictionary]
                let posters = responseDictionary["posters"] as! [NSDictionary]
                self.images = backdrops
                self.images!.appendContentsOf(posters)
                
                self.posterCollection.reloadData()
                //let key = results[0]["key"]! as! String
                //print("backdrops: \(backdrops)")
                //print("posters: \(posters)")
                //self.videoPlayer.loadVideoID(key)
                                                                                
                }
            } else {
                print("..................................................................nothing shown0")
                                                                            
            }
        });
        task1.resume()
        
        
        let url2 = NSURL(string:"https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(apiKey)")
        
        let request2 = NSURLRequest(URL: url2!)
        let session2 = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task2 : NSURLSessionDataTask = session2.dataTaskWithRequest(request2,
            completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                    //NSLog("response: \(responseDictionary)")
                                                                                    
                    print(responseDictionary)
                                                                                    
                    let results = responseDictionary["results"] as! [NSDictionary]
                  
                    self.movies = results
                    
                    self.movieCollection.reloadData()
                    }
                } else {
                    print("..................................................................nothing shown1")
                                                                                
                                                                            }
        });
        task2.resume()
        
        
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
        releaseDateLabel.text = "Released \(releaseDate)"
        ratingCountLabel.text = "\(ratingCount) Ratings"
        averageRatingLabel.text = "\(averageRating)/10 Rating"
        
        //posterView.setImageWithURL(NSURL(string: "https://image.tmdb.org/t/p/original")!)

 
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == videoCollection {
            if let videos = videos {
               // print("count: \(videos.count)")
                return videos.count
            } else {
                print(0)
                return 0
            }

            
        } else if collectionView == posterCollection {
            if let images = images {
                return images.count
            } else {
                return 0
            }
        } else if collectionView == movieCollection {
            if let movies = movies {
                print("similar count: \(movies.count)")
                return movies.count
            } else {
                return 0
            }
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == movieCollection {
            print("indexPath: \(indexPath)")
        }
        
        //print("you've reached cell for row at indexPath")
        if collectionView == videoCollection {
            //print("you've reached video collection")
            let cell = videoCollection.dequeueReusableCellWithReuseIdentifier("VideoCell", forIndexPath: indexPath) as! VideoCell
            
            let video = videos![indexPath.row]
            let key = video["key"] as! String
            
            cell.videoPlayer.loadVideoID(key)

            return cell
            
        } else if collectionView == posterCollection {
            print("you've reached the posterCell")
            let cell = posterCollection.dequeueReusableCellWithReuseIdentifier("PosterCell", forIndexPath: indexPath) as! PosterCell
            
            let backdrop = images![indexPath.row]
            
            
            if let posterPath = backdrop["file_path"] as? String {
                let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
                //let posterUrl = NSURL(string: posterBaseUrl + posterPath)
                //cell.posterView.setImageWithURL(posterUrl!)
                //print("url: \(posterBaseUrl + posterPath)")
                
                //new code after this
                
                //let imageUrl = "https://i.imgur.com/tGbaZCY.jpg"
                let imageRequest = NSURLRequest(URL: NSURL(string: posterBaseUrl + posterPath)!)
                
                cell.posterView.setImageWithURLRequest(
                    imageRequest,
                    placeholderImage: nil,
                    success: { (imageRequest, imageResponse, image) -> Void in
                        
                        // imageResponse will be nil if the image is cached
                        if imageResponse != nil {
                            //print("Image was NOT cached, fade in image")
                            cell.posterView.alpha = 0.0
                            cell.posterView.image = image
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                cell.posterView.alpha = 1.0
                            })
                        } else {    
                            //print("Image was cached so just update the image")
                            cell.posterView.image = image
                        }
                    },
                    failure: { (imageRequest, imageResponse, error) -> Void in
                        // do something for the failure condition
                })
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                cell.posterView.image = nil
            }
            
            
            return cell
        } else if collectionView == movieCollection{
            
            let cell = movieCollection.dequeueReusableCellWithReuseIdentifier("SimilarMovieCell", forIndexPath: indexPath) as! SimilarMovieCell
            
            let similarMovie = movies![indexPath.row]
            cell.movie = similarMovie
            //print("hellloooooo i just entered the non working thingy \(similarMovie["title"])")
            
            if let posterPath = similarMovie["poster_path"] as? String {
                let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
                //let posterUrl = NSURL(string: posterBaseUrl + posterPath)
                //cell.posterView.setImageWithURL(posterUrl!)
                print("url: \(posterBaseUrl + posterPath)")
                
                
                
                //new code after this
                
                //let imageUrl = "https://i.imgur.com/tGbaZCY.jpg"
                let imageRequest = NSURLRequest(URL: NSURL(string: posterBaseUrl + posterPath)!)
                cell.posterImage.setImageWithURLRequest(
                    imageRequest,
                    placeholderImage: nil,
                    success: { (imageRequest, imageResponse, image) -> Void in
                        
                        // imageResponse will be nil if the image is cached
                        if imageResponse != nil {
                            //print("Image was NOT cached, fade in image")
                            cell.posterImage.alpha = 0.0
                            cell.posterImage.image = image
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                cell.posterImage.alpha = 1.0
                            })
                        } else {
                            //print("Image was cached so just update the image")
                            cell.posterImage.image = image
                        }
                    },
                    failure: { (imageRequest, imageResponse, error) -> Void in
                        // do something for the failure condition
                })
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                cell.posterImage.image = nil
            }
            
            
            return cell
            
        }
 
        let cell1 = videoCollection.dequeueReusableCellWithReuseIdentifier("VideoCell", forIndexPath: indexPath) as! VideoCell

        
        return cell1
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is CreditViewController {
            (segue.destinationViewController as! CreditViewController).id = movie!["id"] as! Int
            
        } else if segue.destinationViewController is ReviewViewController {
            (segue.destinationViewController as! ReviewViewController).id = movie!["id"] as! Int
        } else if segue.destinationViewController is DetailViewController {
            (segue.destinationViewController as! DetailViewController).movie = (sender as! SimilarMovieCell).movie!
            
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
