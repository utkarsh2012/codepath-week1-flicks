# Project 1 - Flicks

Flicks is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 3 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [ ] Add a search bar.
- [ ] All images fade in.
- [ ] For the large poster, load the low-res image first, switch to high-res when complete.
- [ ] Customize the highlight and selection effect of the cell.
- [ ] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Added a simple animation effect for Overview in MovieDetail Controller

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![flicks](https://cloud.githubusercontent.com/assets/137799/24584450/394637ee-1723-11e7-91c4-d30579f63737.gif)

## Notes

1. I was always confused between programmatically creating a UIView vs added it to a story board and use it. Creating an element is easier to work with but adding it to storyboard helps using the inspector in xcode. For example using Tab bar, "Network error" UIView.
2. Need to understand the best way to find multiple sizes of images - "Assets" group needs 1x, 2x image sizes but nounproject only gives one size. How to get all the sizes the right way.
3. Refactoring: xcode doesn't allow refactoring Swift code, really hard to improve code quality.

## License

    Copyright [2017] [Utkarsh Sengar]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
