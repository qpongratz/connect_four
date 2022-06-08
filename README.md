# connect_four
A connect four clone created with test driven development to help learn rspec.

Live: https://repl.it/@QuentinPongratz/connectfour#README.md
Hit green run button.

## Learning goals:
- To learn how Test Driven Development

## Learned:
- How hard it is to design tests first.
- How to actually use tests.
- How to stub out methods you're not using.
- How to test private methods indirectly.
- How to actually use instance doubles.

### Notes:
- Was very weird to wrap my mind around how to test things before designing the methods. I think I had to learn, sometimes in order to get where you want with your methods, sometimes you have to (at least as a newbie at this stuff) a test that tests how you think a thing will work, and be open to rewriting the test once you have the method actuallly there. Don't always need to stub everything out that I think I'll have to when first writing the test. So had to learn to be open that just like the code I'm writing is not necessarily the final code after refactors, the tests are just as malleable when you're first writing them. 
  
- I tried super hard to never write a method before writing a test for it. This didn't work out at first, but once I got into actually writing the tests and more of a handle on them,, I was actually adhering to this part of the project. The only other moment I think I struggled with sticking to this, was the winner? method on board. I wrote a test, for confirming vertical wins, and wrote the method checking for all wins. It felt so hard to keep in my mind what I would need to test for, for all the wins, without writing the methods for all of them. And writing a method to search for just vertical wins seemed like a waste as winner needed to check more cases. Looking back, maybe it would have been good and I could have segmented the winner? method to do vertical and horizontal and diagonally as its own sub-methods, but with how I was conceptualizing checking for them, it needed to do all at once. So, I did write a test first, but I didn't adhere to writing the minimum code there. 

- Overall, I think I've gotten more knowledge about testing now. And while it was satisfying for the first time I actually run the code instead of the tests for it just to actually work, I don't know if Test Driven Development is super great. I see the value in writing tests as its good to know if changing something breaks your functionality, but I don't think writing the tests first is always the right answer.
