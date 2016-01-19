//
//  DetailViewController.swift
//  Flicks
//
//  Created by Shakeeb Majid on 1/18/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String {
            let posterURL = NSURL(string: posterBaseUrl + posterPath)
            posterView.setImageWithURL(posterURL!)
        }
        
        
        
        titleLabel.text = title
        overviewLabel.text = overview
        
        
        
        //posterView.setImageWithURL(<#T##url: NSURL##NSURL#>)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
