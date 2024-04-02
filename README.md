# Reddit Automation
This project automates logging into Reddit and posting a comment using Robot Framework and Browser Library(Playwright).

# Installation Instruction
1. Install Python >3.7
2. Install node.js e.g. from https://nodejs.org/en/download/
3. Install python dependencies: pip install -r requirements.txt
4. Install the node dependencies for the newly installed version: rfbrowser init

Robot-Framework Browser Library Keyword Definitation https://marketsquare.github.io/robotframework-browser/Browser.html 

# USAGE
1. Provide Test Data like redit post url, credentials etc in testData\reddit_data.yaml
2. run the robot command from terminal
3. **_robot tests/PostCommentOnReddit.robot_**

    This will run whole robot file which contains only 1 Test Case
