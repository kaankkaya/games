# games
A game list and details that provided by API.

# Structure 
I used MVVM pattern with some additional components like routers, App singleton and delegations. 
View Models fetch or update data, View Controllers handles datas and show it. Using separated Storyboards allowed me to design views in a easier way. 

I used delegation pattern for my view related components because Its more possible to make mistakes (retain cycles, leaks) while working with completions rather than delegations especially with tableView operations using [weak self].

I also care about readability of my code. Completions make code more hard to read while coding complex Views. But using completion for more background operations (image download) more appropriate because you can call these functions any where you like so you don't need to set a delegate.

● How did you decide to use that design and architectural patterns?
I like this structure because I can use this in any app Also this architecture allows developers to handle complex Apps.

● What should be the part of this app that needs more time to develop or improve?
Detail Screen and Favorite storage. I dont like the design of Favorite screens. Using UserDefaults for storing these kind of data iswrong. I used it because it was the easiest way.

● Which part did you like most in this app?
List screen and pagination 

● Does this app ready to submit to store? If not, what should be done to achieve that?
No. Should implement a DB, use View Controller Delegates to handle navigations, have a test.

● Do you have any comments to us?
Sorry for submitting late.

● What are the things you think are missing or open in this assignment?
In instructions it says "design we sent you" but I received none.
