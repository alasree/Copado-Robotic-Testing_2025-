*** Settings ***
Library                         QForce
Library                         QWeb


*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${initial_sleep_time}           5
# ${username}                     Vishnu.r@cloudfulcrum.com.refreshqa2
# ${password}                    Cloud@1234
${username}                     sharooq.a@cloudfulcrum.com 
${password}                    Cloud@1234
${login_url}                    https://test.salesforce.com                             # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    # Setting search order is not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 chrome
    SetConfig                   DefaultTimeout              30s                         #sometimes salesforce is slowEnd suite
    Close All Browsers

Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${password}
    ClickText                   Log In

Home
    [Documentation]    Navigate to homepage, login if needed
    GoTo               ${home_url}
    ${login_status}=   IsText    To access this page, you have to log in to Salesforce.    2
    Run Keyword If     ${login_status}    Login
    
 End suite
    CloseAllBrowsers