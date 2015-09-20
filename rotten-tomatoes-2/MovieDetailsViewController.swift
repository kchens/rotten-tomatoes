//
//  MovieDetailsViewController.swift
//  rotten-tomatoes-2
//
//  Created by Kevin Chen on 9/18/15.
//  Copyright © 2015 Kevin Chen. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailsViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var synopsisLabel: UILabel!
  
  var movie: NSDictionary!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = movie["title"] as? String
    synopsisLabel.text = movie["synopsis"] as? String
    setBackgroundImage()
    
  }

  func setBackgroundImage() {
    // Set low res image first
    let urlString = movie.valueForKeyPath("posters.thumbnail") as! String
    var url = NSURL(string: urlString)!
    imageView.setImageWithURL(url)
    
    sleep(1)
    
    // Set high res images
    var range = urlString.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
    if let range = range {
      url = NSURL(string: urlString.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/"))!
      imageView.setImageWithURL(url)
    }

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
