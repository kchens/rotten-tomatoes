//
//  MoviesViewController.swift
//  rotten-tomatoes-2
//
//  Created by Kevin Chen on 9/18/15.
//  Copyright © 2015 Kevin Chen. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var errorViewCell: ErrorViewCell!
  @IBOutlet weak var tableView: UITableView!

  var movies: [NSDictionary]?
  var refreshControl:UIRefreshControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.errorViewCell.hidden = true
    tableView.dataSource = self
    tableView.delegate = self
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    self.refreshControl.addTarget(self, action: "refreshLoad", forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.addSubview(refreshControl)
    
    refreshLoad()
  }
  
  func refreshLoad() {
    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//    activityIndicator.hidden = false
    
    let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
    let request = NSURLRequest(URL: url)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
      if let json = data {
        self.errorViewCell.hidden = true
//        self.activityIndicator.hidden = true
        
        let json = try! NSJSONSerialization.JSONObjectWithData(json, options: []) as! NSDictionary
        self.movies = json["movies"] as? [NSDictionary]
        self.tableView.reloadData()
        print(json)
        
        self.refreshControl.endRefreshing()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
      } else {
        if let e = error {
          NSLog("Error: \(e)")
          self.refreshControl.endRefreshing()
          
          MBProgressHUD.hideHUDForView(self.view, animated: true)
//          self.activityIndicator.hidden = true
          self.errorViewCell.hidden = false
        }
      }
      
//      if error != nil {
//        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
//        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
//        alert.addAction(action)
//        self.presentViewController(alert, animated: true, completion: nil)
//        self.refreshControl.endRefreshing()
//        self.activityIndicator.hidden = true
//        self.errorViewCell.hidden = false
//        return
//      }

    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let movies = movies {
      return movies.count
    } else {
      return 0
    }
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
    
    let movie = movies![indexPath.row]
    
    cell.titleLabel.text = movie["title"] as? String
    cell.synopsisLabel.text = movie["synopsis"] as? String
    
    let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
    cell.posterView.setImageWithURL(url)
    
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPathForCell(cell)!
    
    let movie = movies![indexPath.row]
    
    let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
    movieDetailsViewController.movie = movie
    
  }


}
