*** Variables ***
${BROWSER}              Chrome
${HEADLESS}             False

*** Settings ***
Library                 OperatingSystem
Library                 SeleniumLibrary
Library                 chromedriver.py
Variables               ../env.yaml

*** Keywords ***
Log And Capture Error
    Capture Page Screenshot
    Log Source

Open New Browser
    [Arguments]          ${url}
    ${chromeDriver}=     chromedriver.Get Chromedriver
    Create Webdriver     ${Browser}    executable_path=${chromeDriver}
    Go To                ${Url}

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
