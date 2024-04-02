*** Settings ***
Library           Browser
Library           Collections
Library           OperatingSystem
Variables         ${EXECDIR}/testData/reddit_data.yaml

*** Variables ***

*** Test Cases ***
Simple Test Case to Post Reddit Comment
    [DOCUMENTATION]     This Test Case opens a reddit post url, logins into reddit 
                    ...  and then post a comment. Username, password, Comment and other test data are defined 
                    ...  in a yaml file stored in testData/reddit_data.yaml
                    
    Set Test Variable    ${reddit_comment}    ${reddit.comment_to_type}
    New Browser    browser=${browser.name}    headless=False
    New Context    viewport={'width': ${browser.width}, 'height': ${browser.height}}
    New Page    ${reddit.thread_url}
    Wait For Load State
    Sleep    5s
    Click    xpath=//*[@source='shreddit_comment_count_button']
    Wait For Load State
    Click    css=auth-flow-link[step="login"]    #CSS selector used because of Shadow-root DOM 
    Type Text    xpath=//input[@id="login-username"]    ${reddit.creds.username}
    Type Secret    xpath=//input[@id="login-password"]    $reddit["creds"]["password"]
    Keyboard Key    press    Enter
    Wait For Elements State   selector=xpath=//input[@id="login-username"]     state=hidden    message=Invalid credentials
    Take Screenshot    login_scuessfull
    Wait For Elements State    xpath=//faceplate-tracker[@noun="add_comment_button"]    state=editable    message= "Your reddit credentials are incorrect! Please modify them accordingly in the credentials.yaml file."
    Click     xpath=//faceplate-tracker[@noun="add_comment_button"] 
    Wait For Load State
    Keyboard Input    type  ${reddit_comment}
    Take Screenshot    comment_typed
    Click    xpath=//button[@slot="submit-button"]
    Wait For Load State
    # A Basic Validation of the last posted commen
    ${input_text}    Get Text    selector=xpath=(//shreddit-comment[@author="replyguy_test"]//div[@slot="comment"])[last()]
                            ...    assertion_operator===    assertion_expected=${reddit_comment}
                            ...    message=Posted comment validation failed
    Log    ${input_text}    console=True
    Take Screenshot    comment_posted
    [TEARDOWN]    Close Browser