//
//  MovieDetailsViewController.swift
//  rotten-tomatoes-2
//
//  Created by Kevin Chen on 9/18/15.
//  Copyright © 2015 Kevin Chen. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var synopsisLabel: UILabel!
  
  var movie: NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()

      titleLabel.text = movie["title"] as? String
      synopsisLabel.text = movie["synopsis"] as? String
      
      let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail")
        as! String)!
      imageView.setImageWithURL(url)
      
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
