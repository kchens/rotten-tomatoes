//
//  MoviesViewController.swift
//  rotten-tomatoes-2
//
//  Created by Kevin Chen on 9/18/15.
//  Copyright © 2015 Kevin Chen. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var errorViewCell: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!

  let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
  
  var movies: [NSDictionary]?
  var filteredMovies: [NSDictionary]?
  var refreshControl:UIRefreshControl!
  var isSearchActive = false
  var userSearchInput = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()

//    self.errorViewCell.hidden = true
    hideNetworkError()
    setUpRefresh()
    
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
  
    refreshLoad()
  }
  
  func setUpRefresh() {
    self.refreshControl = UIRefreshControl()
    self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    self.refreshControl.addTarget(self, action: "refreshLoad", forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.addSubview(refreshControl)
  }
  
  func refreshLoad() {
    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//    activityIndicator.hidden = false
    
    let request = NSURLRequest(URL: url)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
      if let json = data {
//        self.errorViewCell.hidden = true
        self.hideNetworkError()
//        self.activityIndicator.hidden = true
        
        let json = try! NSJSONSerialization.JSONObjectWithData(json, options: []) as! NSDictionary
        self.movies = json["movies"] as? [NSDictionary]

        if self.userSearchInput.characters.count == 0 {
          self.filteredMovies = self.movies
        } else {
          self.filteredMovies = self.filterMoviesOnSearch(self.userSearchInput)
        }
        
        self.tableView.reloadData()
        
        print(json)

        self.refreshControl.endRefreshing()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
      } else {
        if let e = error {
          self.refreshControl.endRefreshing()
          NSLog("Error: \(e)")

          MBProgressHUD.hideHUDForView(self.view, animated: true)
//          self.activityIndicator.hidden = true
//          self.errorViewCell.hidden = false
          self.showNetworkError()
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
  
  func hideNetworkError() {
    UIView.animateWithDuration(1, animations: { () -> Void in
      if self.errorViewCell.alpha == 1 {
        self.tableView.frame.origin.y -= self.errorViewCell.frame.height
        self.tableView.frame.size.height += self.errorViewCell.frame.height
      }
      self.errorViewCell.alpha = 0
    })
  }
  
  func showNetworkError() {
    UIView.animateWithDuration(1, animations: { () -> Void in
      if self.errorViewCell.alpha == 0 {
        self.tableView.frame.origin.y += self.errorViewCell.frame.height
        self.tableView.frame.size.height -= self.errorViewCell.frame.height
      }
      self.errorViewCell.alpha = 1
      self.errorViewCell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
      
    })
  }
  
  // Mark - Search Bar
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    userSearchInput = searchText
    self.searchBar.text = userSearchInput
    
    if userSearchInput == "" {
      filteredMovies = movies
      isSearchActive = false
      searchBar.performSelector("resignFirstResponder", withObject: nil, afterDelay: 0)
    } else {
      isSearchActive = true
      filteredMovies = filterMoviesOnSearch(userSearchInput)
    }
    
    tableView.reloadData()
  }
  
  func filterMoviesOnSearch(searchText: String) -> [NSDictionary] {
    let filteredMovies = self.movies!.filter({ (movie: NSDictionary) -> Bool in
      let stringMatch = (movie["title"] as! String).rangeOfString(searchText)
      return (stringMatch != nil)
    }) as [NSDictionary]
    
    return filteredMovies
  }
  
  // Mark - Table View
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let filteredMovies = filteredMovies {
      return filteredMovies.count
    } else {
      return 0
    }
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
    
    let movie = filteredMovies![indexPath.row]
    
    cell.titleLabel.text = movie["title"] as? String
    cell.synopsisLabel.text = movie["synopsis"] as? String
    
    let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
    cell.posterView.setImageWithURL(url)
    
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
