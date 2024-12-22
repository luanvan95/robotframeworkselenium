*** Variables ***
${CHROME_BROWSER}              chrome
${CHROME_BROWSER_HEADLESS}     headlesschrome
${FIREFOX_BROWSER}             firefox
${FIREFOX_BROWSER_HEADLESS}    headlessfirefox

*** Settings ***
Library                 OperatingSystem
Library                 SeleniumLibrary
Variables               ../env.yaml

*** Keywords ***
Log And Capture Error
    Capture Page Screenshot
    Log Source

Open New Browser
    [Arguments]          ${url}
    [Documentation]      Open Browser using Selenium Library Driver
    ...                  Change with any Browser type you want to use
    Open Browser         ${Url}    ${CHROME_BROWSER_HEADLESS}    options=add_experimental_option("excludeSwitches", ["enable-logging"]);add_argument("--headless");add_argument("--disable-gpu");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")


Open SauceDemo
    Delete Old Files
    Set Screenshot Directory              logs/
    Register Keyword To Run On Failure    Log And Capture Error
    Open New Browser                      ${SauceDemo_URL}

Delete Old Files
    ${curr_y} 	${curr_m} 	${curr_d} 	Get Time	year,month,day
    ${y}	${m}	${d} =	Get Modified Time    logs/	 year,month,day
    IF 	'${curr_y}' != '${y}'
        Run Keyword And Ignore Error          Empty Directory        logs/
    ELSE IF 	 '${curr_m}' != '${m}'
        Run Keyword And Ignore Error          Empty Directory        logs/
    ELSE IF 	 '${curr_d}' != '${d}'
        Run Keyword And Ignore Error          Empty Directory        logs/
    END
