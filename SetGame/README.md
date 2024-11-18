#  Stephens Dexter Project 1
Overall, I believe I deserve an A on this assignment, as my files are well organized in an easy to find format, with each file having marks added for easy finding of specific uses within that folder. I also worked with many of my peers and hopped on calls to help them out with their individual projects, giving guidance and feedback rather than just giving code (Also received much help from others thankfuly). I also took the time to add extra features beyond what was required, as well as utilizing extra tools like extensions to improve the function and readability of the code.

What went well:
- Overall implementation: the project follows MVVM principles, and meets all aspects of the project requirements
- Set Game works: the cards deal correctly, follows correct matching logic, animates successfully, 
- Score calculation: as you play the game, your score is calculated based on the number of cards in play
- Set tracking: as you play the game, the number of sets you have made is tracked
- Sounds: when a match or incorrect match is played, a corresponding sound is played for the user to hear
- Enums: enums are used to track each of the attributes for set cards (following the caseiterable protocol), as well as an enum for the status of the cards
- Closures: I used swift's builtin closures for collections like .filter
- Extension: added an extension to arrays of type setgame.card for looking if the collection has that card

What went not so well:
- Landscape works pretty well, but there can be a slight adjustment glitch where the bottom gets pushed down while it is resizing
- Segregated code: should implement a cardify for the card to be re-usable
- Figure out how to fix the card that stays on the screen as cards are played for new games
- Landscape has an animation issue where the bottom gets pushed off the screen momentarily when new columns are added, so not an error but needs to be smoother ui experience for the user
- Custom created closures: should have taken time to identify how I could create my own custom closures for similar functions
