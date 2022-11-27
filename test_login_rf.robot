*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description


*** Variables ***
${LOGIN URL}  https://scouts-test.futbolkolektyw.pl/en
${BROWSER}  Chrome
${SIGNINBUTTON}  xpath=//*[text()= 'Sign in']
${EMAILINPUT}  xpath=//*[@id='login']
${PASSWORDINPUT}  xpath=//*[@id='password']
${LOGOTITLE}  xpath=//*[text()='Scouts panel - sign in']
${PAGELOGO}  xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${LOGINLOGO}   xpath=//*[contains(@class, 'MuiTypography-root MuiTypography-h5')]
${SIGNOUTBUTTON}  xpath=(//ul[contains(@class, 'MuiList-root')])[2]/div[2]/div/span
${INVALIDLOGINMESSAGE}  xpath=//span[contains(@class, 'MuiTypography-root')]
${BACKTOSIGNINLINK}  xpath=//a[contains(@class, 'MuiTypography-root')]
${BOXTITLE}  xpath=//*[contains(@class, 'MuiTypography-root MuiTypography-h5')]
${ADDPLAYERLOGO}   xpath=//span[contains(@class, 'MuiTypography-h5')]
${ADDPLAYERBUTTON}  xpath=//*[text()='Add player']
${PLAYEREMAILFIELD}  xpath=//input[@name='email']
${PLAYERNAMEFIELD}  xpath=//input[@name='name']
${PLAYERSURNAMEFIELD}  xpath=//input[@name='surname']
${PLAYERPHONEFIELD}  xpath=//input[@name='phone']
${PLAYERWEIGHTFIELD}  xpath=//input[@name='weight']
${PLAYERHEIGHTFIELD}  xpath=//input[@name='height']
${PLAYERDATEOFBIRTH}  xpath=//input[@name='age']
${PLAYERLEGDROPDOWN}  xpath=//*[@id='mui-component-select-leg']
${LEFTLEG}  xpath=//li[@data-value='left']
${RIGHTLEG}  xpath=//li[@data-value='right']
${PLAYERMAINPOSITION}  xpath=//input[@name='mainPosition']
${SUBMITBUTTON}  xpath=//button[@type='submit']/span[1]
${PLAYERNAMEADDEDINMENU}     xpath=//ul[2]/div[1]/div/span[contains(text(),'Jan Kowalski')]


*** Test Cases ***
Login to the system
    Open Login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert Dashboard
    [Teardown]  Close Browser

Leave login empty
    Open Login page
    Leave login field empty
    Type in password
    Click on the Sign in button
    Assert Login page
    Assert empty login message
    [Teardown]      Close Browser

Type in invalid password
    Open Login page
    Type in email
    Type invalid password
    Click on the Sign in button
    Assert Login page
    Assert invalid password message
    [Teardown]      Close Browser

Assert text of the sign in box title
    Open Login page
    Check text of the box title by xpath
    [Teardown]  Close Browser

Add new player
    Open Login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert Dashboard
    Click on Add Player button
    Type in player's email
    Type in player's name
    Type in player's surname
    Type in player's phone
    Type in player's weight
    Type in player's height
    Type in player's date of birth
    Type in player's main position
    Select player's right leg
    Click on the Submit button
    Assert added player in menu
    [Teardown]      Close Browser


*** Keywords ***
Open Login page
    Open Browser  ${LOGIN URL}  ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text    ${EMAILINPUT}     user07@getnada.com
Type in password
    Input Text    ${PASSWORDINPUT}    Test-1234
Click on the Sign in button
    Click Element     ${SIGNINBUTTON}
Assert Dashboard
    Wait Until Element Is Visible     ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot    alert.png
Leave login field empty
    Input Text      ${EMAILINPUT}   ${EMPTY}
Assert empty login message
    Wait Until Element Is Visible     ${INVALIDLOGINMESSAGE}
    Element Text Should Be    ${INVALIDLOGINMESSAGE}    Please provide your username or your e-mail.
    Capture Page Screenshot    alert.png
Type invalid password
    Input Text    ${PASSWORDINPUT}    Test-4444
Assert invalid password message
    Wait Until Element Is Visible    ${INVALIDLOGINMESSAGE}
    Element Text Should Be    ${INVALIDLOGINMESSAGE}    Identifier or password invalid.
    Capture Page Screenshot    alert.png
Check text of the box title by xpath
    Wait Until Element Is Visible    ${LOGINLOGO}
    Element Text Should Be    ${BOXTITLE}    Scouts Panel
    Capture Page Screenshot    alert.png
Click on Add Player button
    Click Element   ${ADDPLAYERBUTTON}
    Wait Until Element Is Visible    ${ADDPLAYERLOGO}
Type in player's email
    Input Text    ${PLAYEREMAILFIELD}    j.kowalski@gmail.com
Type in player's name
    Input Text    ${PLAYERNAMEFIELD}    Jan
Type in player's surname
    Input Text    ${PLAYERSURNAMEFIELD}    Kowalski
Type in player's phone
    Input Text    ${PLAYERPHONEFIELD}    +48222222111
Type in player's weight
    Input Text    ${PLAYERWEIGHTFIELD}    86
Type in player's height
    Input Text    ${PLAYERHEIGHTFIELD}    186
Type in player's date of birth
    Input Text    ${PLAYERDATEOFBIRTH}    08/11/1981
Type in player's main position
    Input Text    ${PLAYERMAINPOSITION}    stricker
Select player's right leg
    Click Element    ${PLAYERLEGDROPDOWN}
    Click Element    ${RIGHTLEG}
Click on the Submit button
    Click Element    ${SUBMITBUTTON}
Assert added player in menu
    Wait Until Element Is Visible    ${PLAYERNAMEADDEDINMENU}
    Element Text Should Be    ${PLAYERNAMEADDEDINMENU}    Jan Kowalski
    Capture Page Screenshot    alert.png
Click on the Sign out button
    Click Element    ${SIGNOUTBUTTON}
Assert Login page
    Wait Until Element Is Visible   ${LOGINLOGO}
    Title Should Be   Scouts panel - sign in
    Capture Page Screenshot     alert.png
