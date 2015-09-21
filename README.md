Rotten Tomatoes

NOTES:  Had to completely rebuild the app due to some iOS 9 and Swift 2.0 issue. Moreover, spent a lot of time dealing with stacking Interface Builder elements. Spent several hours trying to build out collections view.

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: `14`

### Features

#### Required

- [X] User can view a list of movies. Poster images load asynchronously.
- [X] User can view movie details by tapping on a cell.
- [X] User sees loading state while waiting for the API.
- [X] User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- [X] User can pull to refresh the movie list.

#### Optional

- [X] All images fade in.
- [X] For the larger poster, load the low-res first and switch to high-res when complete.
- [ ] All images should be cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `NSURLRequestReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [ ] Customize the highlight and selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Add a tab bar for Box Office and DVD.
- [X] Add a search bar: pretty simple implementation of searching against the existing table view data.

### Walkthrough
![Rotten Tomatoes](https://raw.githubusercontent.com/kchens/rotten-tomatoes/master/rotten-tomatoes-2.gif)
![Search Function](https://raw.githubusercontent.com/kchens/rotten-tomatoes/master/rotten-tomatoes-2-search.gif)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
