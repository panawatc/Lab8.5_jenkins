*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open KKU Computing Website
    Open Browser To Login Page
    Capture Page Screenshot


*** Keywords ***
Open Browser To Login Page
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    
    # 1. Path ของ Chromium Browser
    ${chrome_options.binary_location}=    Set Variable    /usr/bin/chromium

    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --headless
    
    # 2. Path ของ Driver
    ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path='/usr/bin/chromedriver')    sys, selenium.webdriver.chrome.service

    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    
    Go To    https://computing.kku.ac.th