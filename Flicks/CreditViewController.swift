//
//  CreditViewController.swift
//  Flicks
//
//  Created by Shakeeb Majid on 8/3/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class CreditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var id: Int?
    var cast: [NSDictionary]?
    var crew: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
       
        print(id!)
        self.title = "Cast & Crew"
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(id!)/credits?api_key=\(apiKey)")
        
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
                    self.cast = result!["cast"] as? [NSDictionary]
                    self.crew = result!["crew"] as? [NSDictionary]
                    
                    print("cast: \(self.cast)")
                    print("crew: \(self.crew)")
                    
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
    
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Cast"
        } else if section == 1 {
            return "Crew"
        }
        
        return "not a real header"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let cast = cast {
            print("cast reached")
            if section == 0 {
                return cast.count
            }
            
        }
        if let crew = crew {
            print("crew reached")
            if section == 1 {
                return crew.count
            }
            
        }
        print("hello you reached 0")
        return 0
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCell", forIndexPath: indexPath) as! PersonCell
        
        var castMember: NSDictionary
        var crewMember: NSDictionary
        print("indexPath: \(indexPath)")
        
        
        if indexPath.section == 1 {
            crewMember = crew![indexPath.row] as! NSDictionary
            
            let name = crewMember["name"] as! String
            let job = crewMember["job"] as! String
            
            cell.nameLabel.text = name
            cell.characterLabel.text = job
            
            if let posterPath = crewMember["profile_path"] as? String {
                let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            
                let imageRequest = NSURLRequest(URL: NSURL(string: posterBaseUrl + posterPath)!)
                
                cell.actorPhotoView.setImageWithURLRequest(
                    imageRequest,
                    placeholderImage: nil,
                    success: { (imageRequest, imageResponse, image) -> Void in
                        
                        // imageResponse will be nil if the image is cached
                        if imageResponse != nil {
                            //print("Image was NOT cached, fade in image")
                            cell.actorPhotoView.alpha = 0.0
                            cell.actorPhotoView.image = image
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                cell.actorPhotoView.alpha = 1.0
                            })
                        } else {
                            //print("Image was cached so just update the image")
                            cell.actorPhotoView.image = image
                        }
                    },
                    failure: { (imageRequest, imageResponse, error) -> Void in
                        // do something for the failure condition
                })
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                cell.actorPhotoView.image = nil
            }
            
        } else {
            castMember = cast![indexPath.row] as! NSDictionary
            
            let name = castMember["name"] as! String
            let character = castMember["character"] as! String
            
            cell.nameLabel.text = name
            cell.characterLabel.text = character
            if let posterPath = castMember["profile_path"] as? String {
                let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
                
                let imageRequest = NSURLRequest(URL: NSURL(string: posterBaseUrl + posterPath)!)
                
                cell.actorPhotoView.setImageWithURLRequest(
                    imageRequest,
                    placeholderImage: nil,
                    success: { (imageRequest, imageResponse, image) -> Void in
                        
                        // imageResponse will be nil if the image is cached
                        if imageResponse != nil {
                            //print("Image was NOT cached, fade in image")
                            cell.actorPhotoView.alpha = 0.0
                            cell.actorPhotoView.image = image
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                cell.actorPhotoView.alpha = 1.0
                            })
                        } else {
                            //print("Image was cached so just update the image")
                            cell.actorPhotoView.image = image
                        }
                    },
                    failure: { (imageRequest, imageResponse, error) -> Void in
                        // do something for the failure condition
                })
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                cell.actorPhotoView.image = nil
            }
            
            
        }
        
        return cell
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
