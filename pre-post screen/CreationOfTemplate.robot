*** Settings ***
Library                         QWeb
# Sanbox Refresh Regression Suite
# Developed by: CloudFulcrum India Pvt. Ltd.
# Description: Automates the Create template on Sandbox Refresh
Resource                        ../Resources/Common.robot
Resource                        ../Resources/Keywords.robot
Resource                        ../Resources/Variables.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         Process
Library                         OperatingSystem
Library                         QVision                     Qweb

*** Keywords ***
Run Script File
    [Arguments]                 ${path}
    File Should Exist           ${path}
    ${result}=                  Run Process                 robot            ${path}                     stdout=stdout.txt    stderr=stderr.txt
    Log File                    stdout.txt
    Log File                    stderr.txt
    Should Be Equal As Integers                             ${result.rc}     0
*** Variables ***
${Apexscriptxpath}              xpath=//textarea[@placeholder="Enter your Apex script..."]
# @{REFRESH_ENVIRONMENTS}       RefreshQA                   RefreshPoc       refreshqa2                  refreshqa1
${AUTH_ERROR_MSG}               The org selected is not authenticated. Please authenticate it.
${ERROR_MSG}
${actual_error}                 Null
${search}                       xpath=//input[@placeholder="Search..."]
${Enterthescript}               xpath=//textarea[@placeholder="Enter your Apex script..."]
${users_Empty}                  No User data available for the selected data type in the org.
@{Users_Selection}              Select Item 1               Select Item 2    Select Item 3               Select Item 4
@{Custom_settings}              Select Item 1               Select Item 2    Select Item 3               Select Item 4        Select Item 5
@{ScheduledJobs}                Select Item 1               Select Item 2    Select Item 3               Select Item 4
${xpath_of_iploadfile}          xpath=(//span[contains(@class, 'slds-file-selector__text') and contains(@class, 'slds-medium-show')])[1]
*** Test Cases ***
Select And Authenticate Refresh Environment
                            #   Set Library Search Order    QForce           QWeb
                            #   Open Browser                about:blank      chrome

    [Documentation]             This test case selects a sandbox environment, handles authentication if needed,applies metadata masking rules, selects users, and creates a refresh template.
    ....It uses Copado Robotic Testing with QVision and QWeb.
    [Tags]                      RefreshFlow

    # Step 1: Launch refresh flow in the application
      Appstate                    Home
    # Sleep                     10
    # GoTo                      https://test.salesforce.com
    # TypeText                  username                    Vishnu.r@cloudfulcrum.com.refreshqa2
    # TypeText                  password                    Cloud@1234
    # ClickText                 Log in to Sandbox
    LaunchApp                   Post Refresh Automation
    ClickText                   Create Template
    ClickText                   Refresh a Sandbox
    ClickText                   Next
    Selection of Org Retreival
    ClickElement                xpath=//button[@name="selectMetadata"]
    Metadata Retreival
    Selecting the Masking Type
    Select the Suffix Masking
    Select the ApexScript
    Selecting the users
    Selecting the Custom Settings
    Selecting the Scheduled Jobs
    Last Step of creation of Template
    Steps For Edit Template
    Edit MetadataRetrival
    Editing the Search and Replace Values
    Editing the Suffix Values in EditTemplate
    Editing the ApexScript
    Editing the Users
    Retrieve Data
    SearchBar for ApexClass
    SCREEN 2 SANDBOX REFRESH
    MetadataRestore SCREEN
    Metadata Tranformation without Upload of file
    DataRestore Screen of Users
    DataRestore Screen of Custom Settings
    DataRestore Screen of Scheduled Jobs
    DataRestore Screen of DeleteScheduledJobs
    User Transformation
    UserTranformation user Activate
    DataTranformation
    second DataTranformation
    Related




















