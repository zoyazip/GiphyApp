# GiphyApp
Test task for ChiliLabs

## Technologies:
In this project I have used:
- iOS 16, as more than 90% on AppStore are using this version
- Swift
- SwiftUI
- UIKit - for opening link in browser
- Combine - Reactive programming
- SDWebImage Library - for displaying images on the screen
- MVVM pattern

## Notes:

This app contains 2 Screens
- Main Screen - represents fetched gifs as a Vertical grid, has default search bar and trending list.
- Detail Screen - represents a details of selected gif from Main Screen. Contains Image, information, 2 Buttons - Open original in browser and copy gif in clipboard.

To fetch the data I have created generic function inside NetworkManager, which returns AnyPublisher<T, NetworkError>. This allows to use this fetching method in different ways.
  
Because api's response is JSON, my fetched data is represented as a GifModel struct, with parameters, such as, id, url, author, date etc..
As well, there is model for Searching trends, which has only one field: data as String.

In this project I have used MVVM pattern, which is beter used along with SwiftUI, I have created ViewModel, which contains all logic. It has 
different ways to fetch data by Prompt or by Trending, as well it fetches Trending search. Fills data array with fetched data, clean previous data etc..

In this app instead of simple Strings for URL's I'm using URL Builder, which builds safe URLs for me

As well, I'm using extencion for color converting from Hex code.

## Screenshots:

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/0351ffc1-259c-45ad-93b9-bcf633dd4e77" width="300"/>

### Main screen

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/1f106298-431c-42f4-8586-93fd3f4512e1" width="970"/>

### Landscape Mode

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/bcc07b14-b139-414e-9035-893b2cab4d45" width="300"/>

### Searching new gifs by user promt and displaying loading indicators, when gifs are loading

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/dc78ce31-62b9-4024-9f1c-4ac5092498ee" width="300"/>

### Showing detail Screen

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/b6176a5e-0997-480e-b423-b24302bcc100" width="300"/>

### Showing Copying functionality. When link is copied, the alert occurs

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/673a228b-0931-4116-b3e1-7011b495331e" width="300"/>

### Pressing on "See Original" Button will be opened browser with link of this gif

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/829960f3-3f59-4be1-a758-4bd93ea40345" width="300"/>

### Showing "No results" if there is no results by prompt

<img src="https://github.com/zoyazip/GiphyApp/assets/67118409/a332fa95-47d2-4e65-b37c-b72cb59d7347" width="300"/>

### Showing user error caused by limit of prompt
