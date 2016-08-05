//
//  ReviewViewController.swift
//  Flicks
//
//  Created by Shakeeb Majid on 8/3/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var id: Int?
    var reviews: [NSDictionary]?
    var movie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Reviews"
        print(id!)
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(id!)/reviews?api_key=\(apiKey)")
        
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
                                                                            
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                //NSLog("response: \(responseDictionary)")
                                                                                
                let result = responseDictionary as? NSDictionary
                self.reviews = result!["results"] as? [NSDictionary]
                
                
                print("result: \(result)")
                
                self.tableView.reloadData()
                }
            } else {
                print("..........nothing shown0")
            }
        });
        task.resume()
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let reviews = reviews {
            return reviews.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewCell", forIndexPath: indexPath) as! ReviewCell
        
        let review = reviews![indexPath.row]
        cell.review = review
        cell.authorLabel.text = "-\(review["author"] as! String)"
        cell.contentLabel.text = review["content"] as! String
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! ReviewCell
        
        let review = cell.review!
        
        let fullReviewVC = segue.destinationViewController as! FullReviewViewController
        
        fullReviewVC.review = review
        fullReviewVC.movie = self.movie!
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
