# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **14** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] Customize the UI.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough 

Here's a walkthrough of implemented user stories:
<img src='http://i.imgur.com/GJYAYkq.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

CocoaPods did not install initially due to changes to OS X El Capitan.

## License

    Copyright [2016] [Shakeeb Majid]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
#R.I.P David Bowie (8th January 1947 – 10th January 2016)
<img src='https://media4.giphy.com/media/yoJC2wQqhXpm97vdeg/200w.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


# Project 2 - *Flicks*

**Flicks** is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **40** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view movie details by tapping on a cell.
- [x] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [x] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [x] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Infinite scrolling on each list of movies
- [x] Upcoming and Popular movie lists added, each with their own tab bar item
- [x] Trailers of movies on YouTube can be opened straight from the details view controller
- [x] Ability to browse posters and backdrops of a movie
- [x] User can jump from one movie's details to a similar movie's details by browsing the "similar movies" collection
- [x] List of Cast and Crew in a movie and the characters/jobs they performed as
- [x] All reviews posted to the database for a movie can be read
- [x] Ratings and release date are also portrayed on the detail view
- [x] detail scrollview transitions from translucent to opaque upon scrolling down

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/0CVsJ8U.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Search through movies that are currently in theatres, top rated, popular, or upcoming

<img src='http://i.imgur.com/uiBRbXo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Browse a movie's trailers, posters, backdrops and related movies

<img src='http://i.imgur.com/ioBgsfG.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Discover a movie's cast, read its reviews, and search for specific titles

<img src='http://i.imgur.com/HjQaera.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes
Implementing Auto-Layout constraints on a scroll view proved to be more difficult than expected due to the necessary content size requirements of a scroll view

Special thanks to gilesvangruisen for the YouTubePlayer framework which allows Flicks to play trailers and ashleymills for Reachability which allows Flicks to detect whether or not the user is connected to a network and able to refresh their movie feeds

## License

    Copyright [2016] [Shakeeb Majid]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
