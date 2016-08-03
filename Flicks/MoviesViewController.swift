//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Shakeeb Majid on 1/13/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import AFNetworking
import EZLoadingActivity

class MoviesViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {

    //@IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var errorView: UIView!
    
    
    var movies: [NSDictionary]?
    var searchedMovies: [NSDictionary]?
    var refreshControl: UIRefreshControl!
    
    var endpoint: String!
    
    var isMoreDataLoading = false
    var page = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.hidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.grayColor()
        self.navigationItem.titleView = UISearchBar()
        (self.navigationItem.titleView as! UISearchBar).delegate = self
        
        flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height / 2.5)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
       // EZLoadingActivity.hide()
        collectionView.dataSource = self
        
        (collectionView as! UIScrollView).delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        
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

                    self.errorView.hidden = true

                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.collectionView.reloadData()
                    }
                    print("Something shown")
                } else {
                    print("..........nothing shown0")
                    self.errorView.hidden = false
                    
                    
                }
        });
        task.resume()
    }
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        onRefresh()
    }
    
    
 
    
    func onRefresh() {
        EZLoadingActivity.show("Loading...", disableUI: true)
       
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )

        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            errorView.hidden = true
        } else {
            print("Network not reachable")
            errorView.hidden = false
        }
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if (error != nil) {
                    print("error")
                }
                if let data = dataOrNil {
                    print("hello why are you working")
                    //self.errorView.hidden = true
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                        if responseDictionary["results"] == nil {
                            print("error2")
                        }
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.collectionView.reloadData()
                    } else {
                        
                        print("1.................nothing shown")
                    }
                    
                }
                else {
                    print("............nothing Shown2")
                    //self.errorView.hidden = false
                    //self.view.bringSubviewToFront(self.errorView)
                   // self.view.bringSubviewToFront(<#T##view: UIView##UIView#>)
                    //self.errorButton.hidden = false
                    //self.tableView.hidden = true
                    
                }
                //EZLoadingActivity.hide(success: true, animated: true)
        });
        
        task.resume()
        delay(1, closure: {
            self.refreshControl.endRefreshing()
            EZLoadingActivity.hide(success: true, animated: true)
        })
        //self.refreshControl.endRefreshing()
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let searchedMovies = searchedMovies {
            return searchedMovies.count
        } else if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCollectionCell", forIndexPath: indexPath) as! MovieCollectionCell
        
        var movie: NSDictionary?
        
        if let searchedMovies = searchedMovies {
            movie = searchedMovies[indexPath.row]
            
        } else {
            movie = movies![indexPath.row]

        }
        
        
        print(movie!["title"])
        if let posterPath = movie!["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            //let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            //cell.posterView.setImageWithURL(posterUrl!)
            
            
            
            
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
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("hello")
        var query = searchBar.text! as! String
        print("hello 1")
        if query == "" {
            searchedMovies = nil
            collectionView.reloadData()
            
            
            
        } else {
            if let movies = movies {
                print("hello 2 ")
                searchedMovies = []
                for movie in movies {
                    print("hello 3")
                    
                    let title = movie["title"] as! String
                    print("hello 4")
                    
                    if title.containsString(query) {
                        print("hello 5")
                        
                        searchedMovies!.append(movie)
                        print("hello 6")
                        
                        
                    }
                    print("hello 7")
                    
                }
                print("hello 8")
                
                collectionView.reloadData()
                //searchedMovies = nil
                print("hello 9")
                
            }

            
            
        }
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //view.addGestureRecognizer(tap)
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchedMovies = nil
    
        collectionView.reloadData()
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        print("hey you")
         //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
       // view.removeGestureRecognizer(tap)
        //(self.navigationItem.titleView as! UISearchBar).resignFirstResponder()
        self.navigationItem.titleView!.endEditing(true)
        print("yeah you")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        print("hello")
        if (!isMoreDataLoading) {
            
            print("hello 0")
            let scrollViewContentHeight = collectionView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - collectionView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && collectionView.dragging) {
                isMoreDataLoading = true
                print("hello1")
                loadMoreData()
                // ... Code to load more results ...
            }
            
            
            // ... Code to load more results ...
            
        }
        
    }
    
    func loadMoreData() {
        print("hello2")
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)&page=\(page)")
        page += 1
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
                                                                            
                self.errorView.hidden = true
                                                                            
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as?NSDictionary {
                    //NSLog("response: \(responseDictionary)")
                                                                                
                    let moviesPage = responseDictionary["results"] as? [NSDictionary]
                    for movie in moviesPage! {
                        self.movies!.append(movie)
                    }
                    self.isMoreDataLoading = false

                    self.collectionView.reloadData()
                }
                print("Something shown")
                } else {
                    print("..........nothing shown0")
                    self.errorView.hidden = false
                                                                            
                                                                            
                }
        });
        task.resume()
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)

        var movie = movies![indexPath!.row]
        if let searchedMovies = searchedMovies {
            movie = searchedMovies[indexPath!.row]
        }

        
        let detailViewController = segue.destinationViewController as! DetailViewController

        
        detailViewController.movie = movie
    }

}




/* func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 if let movies = movies {
 return movies.count
 } else {
 return 0
 }
 }
 
 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
 
 let backgroundView = UIView()
 backgroundView.backgroundColor = UIColor(red: 179/255, green: 0/255, blue: 89/255, alpha: 0.8)
 cell.selectedBackgroundView = backgroundView
 
 
 let movie = movies![indexPath.row]
 let title = movie["title"] as! String
 let overview = movie["overview"] as! String
 if let posterPath = movie["poster_path"] as? String {
 let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
 //let posterUrl = NSURL(string: posterBaseUrl + posterPath)
 //cell.posterView.setImageWithURL(posterUrl!)
 
 
 
 
 //new code after this
 
 //let imageUrl = "https://i.imgur.com/tGbaZCY.jpg"
 let imageRequest = NSURLRequest(URL: NSURL(string: posterBaseUrl + posterPath)!)
 
 cell.posterView.setImageWithURLRequest(
 imageRequest,
 placeholderImage: nil,
 success: { (imageRequest, imageResponse, image) -> Void in
 
 // imageResponse will be nil if the image is cached
 if imageResponse != nil {
 print("Image was NOT cached, fade in image")
 cell.posterView.alpha = 0.0
 cell.posterView.image = image
 UIView.animateWithDuration(0.3, animations: { () -> Void in
 cell.posterView.alpha = 1.0
 })
 } else {
 print("Image was cached so just update the image")
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
 
 
 cell.titleLabel.text = title
 cell.overviewLabel.text = overview
 
 
 print("row \(indexPath.row)")
 return cell
 
 } */
