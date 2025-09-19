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
    ${result}=                  Run Process                 robot                       ${path}                     stdout=stdout.txt    stderr=stderr.txt
    Log File                    stdout.txt
    Log File                    stderr.txt
    Should Be Equal As Integers                             ${result.rc}                0
*** Variables ***
${Apexscriptxpath}              xpath=//textarea[@placeholder="Enter your Apex script..."]
# @{REFRESH_ENVIRONMENTS}       RefreshQA                   RefreshPoc                  refreshqa2                  refreshqa1
${AUTH_ERROR_MSG}               The org selected is not authenticated. Please authenticate it.
${ERROR_MSG}
${actual_error}                 Null
${search}                       xpath=//input[@placeholder="Search..."]
${Enterthescript}               xpath=//textarea[@placeholder="Enter your Apex script..."]
${users_Empty}                  No User data available for the selected data type in the org.
@{Users_Selection}              Select Item 1               Select Item 2               Select Item 3               Select Item 4        Select Item 5
@{Custom_settings}              Select Item 1               Select Item 2               Select Item 3               Select Item 4        Select Item 5
@{ScheduledJobs}                Select Item 1               Select Item 2               Select Item 3               Select Item 4        Select Item 5
${xpath_of_iploadfile}      xpath=(//span[contains(@class, 'slds-file-selector__text') and contains(@class, 'slds-medium-show')])[1]
*** Test Cases ***
Select And Authenticate Refresh Environment
                            #   Set Library Search Order    QForce                      QWeb
                            #   Open Browser                about:blank                 chrome

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


Metadata Retreival

    FOR                         ${Metadata_Type}            IN                          @{Metadata_Types}

        Log To Console          ${Metadata_Type}
        ClickText               ${SelectMetadata}           timeout=10s
        ClickText               ${Metadata_Type}            timeout=40s

        Sleep                   3s
        ${data_exists}=         Run Keyword And Return Status                           VerifyText                  Search Metadata Components                timeout=3s
        IF                      ${data_exists}
        # Click Checkbox        Select All                  on                          index=1                     timeout=20s
        # # ClickText           Next                        anchor=Last
        # # Click Checkbox      Select All                  on                          index=1                     timeout=20s
            ClickText           Select Item 1
            ClickText           Select Item 2
            ClickText           Select Item 3

        ELSE
            Log To Console      do nothing
        END
    END
    ClickText                   Next                        anchor=Back
    Selecting the Masking Type
Select the Suffix Masking
    ClickElement                xpath=//button[@name="selectMaskingType"]
    ClickText                   Suffix
    # ClickElement              xpath=//div[@data-value="CustomLabel"]
    ClickElement                xpath=//span[@title="Custom Labels"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="ConnectedApp"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="CustomMetadata"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    # sleep                     30s
    ClickElement                xpath=//div[@data-value="EmailServicesFunction"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="WorkflowAlert"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//input[@placeholder="Enter the suffix value..."]
    WriteText                   .invalid
    ClickElement                xpath=//button[@title="Create Rule"]

    ClickElement                xpath=//button[@name="selectMaskingType"]
Select the ApexScript
    ClickText                   Apex Script
    ClickElement                xpath=//input[@inputmode="decimal"]
    WriteText                   1
    ClickElement                xpath=(//input[@required=""])[2]
    WriteText                   Account Creation
    ClickElement                xpath=//textarea[@placeholder="Enter your Apex script..."]
    # TypeText                  ${Apexscriptxpath}          ${apexscript}
    WriteText                   ${AccountCreation}
    ClickElement                xpath=//button[@title="Add Script"]
    ClickText                   Next                        anchor=Back

    ClickElement                xpath=//button[@name="selectData"]
    ClickText                   Users
    Scroll                      //html                      page_up
    FOR                         ${SelectedUsers}            IN                          @{Users_Selection}
        ClickText               ${SelectedUsers}
    END
    ClickElement                xpath=//INPUT[@placeholder="Search..."]
    writeText                   Biswa Mishra
    ClickElement                xpath=//button[text()='Search']
    ClickText                   Select Item 1
    #                           ClcikText                   Search Users
    ClickElement                xpath=//input[@placeholder="Search..."]
    ClickText                   Clear
Selecting the Custom Settings
    ClickElement                xpath=//button[@name="selectData"]
    ClickText                   Custom Settings
    FOR                         ${CS}                       IN                          @{Custom_settings}
        ClickText               ${CS}
    END
Selecting the Scheduled Jobs
    ClickElement                xpath=//button[@name="selectData"]
    ClickText                   Scheduled Jobs
    FOR                         ${Selected_ScheduledJobs}                               IN                          @{ScheduledJobs}
        ClickText               ${Selected_ScheduledJobs}
    END
    ClickText                   Next                        anchor=Back
Last Step of creation of Template
    # Generate random account data
    Evaluate                    random.seed()               random                      # initialize random generator
    ${random_string}=           Generate Random String      1                           [NUMBERS]
    ${Name_of_Template}=        Set Variable                RefreshTemplate_${random_string}
    Set Variable                ${Name_of_Template}

    TypeText                    Template Name               ${Name_of_Template}         anchor= Selected Target Org:
    ClickText                   Create Template

    VerifyText                  ${Name_of_Template}
    ClickText                   ${Name_of_Template}
    VerifyText                  Metadata/Data Retrieval is in progress. The progress will shift to "Sandbox Refresh" stage once the retrieval is done. Please refresh the page to check the status!
    RefreshPage
    RefreshPage
    Scroll                      //html                      page_up
Steps For Edit Template
    ClickText                   Edit Template
Edit MetadataRetrival

    FOR                         ${Metadata_Type}            IN                          @{Metadata_Types}
        Log To Console          ${Metadata_Type}
        ClickText               ${SelectMetadata}           timeout=10s
        ClickText               ${Metadata_Type}            timeout=40s

        Sleep                   10s
        ${data_exists}=         Run Keyword And Return Status                           VerifyText                  Search Metadata Components                timeout=3s
        IF                      ${data_exists}
            Click Checkbox      Select All                  on                          anchor=All Metadata index=1                      timeout=20s
            # # ClickText       Next                        anchor=Last
            # # Click Checkbox                              Select All                  on                          index=1              timeout=20s
            # Click
            #                   ClickText                   Select Item 1 Chosse a Row
            #                   ClickText                   Select Item 2 Chosse a Row
            #                   ClickText                   Select Item 3 Chosse a Row

        ELSE
            Log To Console      do nothing
        END
    END
    ClickText                   Next                        anchor=Back
Editing the Search and Replace Values
    # ClickElement              xpath=//button[@name="selectMaskingType"]
    ClickElement                xpath=//button[@name="selectMaskingTypeForEdit"]
    ClickText                   Search & Replace
    ClickElement                xpath=//div[@data-value="AuthProvider"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="CustomLabel"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="CustomMetadata"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="NamedCredential"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="RemoteSiteSetting"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="WorkflowAlert"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//input[@placeholder="Type the value..."]
    Write Text                  Google1
    ClickElement                xpath=//input[@placeholder="Type the value you want to replace with..."]
    Write Text                  zoho1
    ClickElement                xpath=//button[@title="Create Rule"]
    ${Success_message}=         GetText                     6 rules created successfully
    Log To Console              ${Success_message}=
Editing the Suffix Values in EditTemplate
    # ClickElement              xpath//button[@name="selectMaskingTypeForEdit"]
    ClickElement                xpath=//button[@data-value="Search & Replace"]
    ClickText                   Suffix
    # ClickElement              xpath=//div[@data-value="CustomLabel"]
    ClickElement                xpath=//span[@title="Custom Labels"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="ConnectedApp"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="CustomMetadata"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    # sleep                     30s
    ClickElement                xpath=//div[@data-value="EmailServicesFunction"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//div[@data-value="WorkflowAlert"]
    ClickElement                xpath=//button[@title="Move to Selected"]
    ClickElement                xpath=//input[@placeholder="Enter the suffix value..."]
    WriteText                   .invalid
    ClickElement                xpath=//button[@title="Create Rule"]
    VerifyText                  A Suffix rule for metadata type "CustomMetadata" already exists!
    VerifyText                  A Suffix rule for metadata type "ConnectedApp" already exists!
    VerifyText                  A Suffix rule for metadata type "CustomLabel" already exists!
    Rest
    VerifyText                  A Suffix rule for metadata type "WorkflowAlert" already exists!
    VerifyText                  A Suffix rule for metadata type "EmailServicesFunction" already exists!
    # ClickElement              xpath//button[@name="selectMaskingTypeForEdit"]
    ClickElement                xpath= //button[@data-value="Suffix"]
Editing the ApexScript
    ClickText                   Apex Script
    ClickElement                xpath=//input[@inputmode="decimal"]
    WriteText                   2
    ClickElement                xpath=(//input[@required=""])[2]
    WriteText                   Account Creation 01
    ClickElement                xpath=//textarea[@placeholder="Enter your Apex script..."]
    # TypeText                  ${Apexscriptxpath}          ${apexscript}
    WriteText                   ${AccountCreation}
    ClickElement                xpath=//button[@title="Add Script"]
    VerifyText                  Script added Successfully
Editing the Users
    ClickElement                xpath=//button[@name="selectDataForEdit"]
    ClickText                   Users
    VerifyText                  Biswa Mishra
    ClickText                   Select Item 1
    ClickElement                xpath=//button[@name="selectDataForEdit"]
    #                           ClickElement                xpath=//button[@data-value="Custom Settings"]
    ClickText                   Custom Settings
    ClickText                   Select Item 1
    ClickElement                xpath=//button[@name="selectDataForEdit"]
    ClickText                   Scheduled Jobs
    ClickText                   Select Item 2
    ClickText                   Next                        anchor=Back
    ClickText                   Update Template             anchor=Back
    VerifyText                  Updating the template...
    VerifyText                  Metadata/Data Retrieval is in progress. The progress will shift to "Sandbox Refresh" stage once the retrieval is done. Please refresh the page to check the status!
    RefreshPage
    sleep                       5s
    RefreshPage
    Clicktext                   Retrieve Metadata
    VerifyText                  Metadata regeneration initiated. Please wait while files are being generated.
    # ClickIcon                 Refresh
    Sleep                       5s
    ClickItem                   Refresh
    ClickItem                   Refresh
    ClickItem                   Refresh
    RefreshPage
    ClickItem                   Refresh
    # VerifyText                Metadata Backup Completed
    Clicktext                   Retrieve Data
    VerifyText                  Choose Data to Regenerate
    ClickText                   Submit
    Sleep                       3s
    VerifyText                  Data regeneration initiated. Please wait while files are being generated.
    ClickItem                   Refresh
    Verifytext                  Data Backup In Progress
    VerifyText                  Scheduled Jobs - Backup Regeneration Backup Completed
    VerifyText                  Users - Backup Regeneration Backup Completed
    sleep                       5s
    RefreshPage
    ClickItem                   Refresh

    ClickItem                   Refresh
    Verifytext                  Custom Settings - Backup Regeneration Backup Completed
    Clicktext                   Next                        anchor=Edit Template
    ClickElement                xpath=//select[@value="5"]                              anchor=Showing
    # ClickText                 25                          anchor=10
    HotKey                      down
    # ClickText                 10
SearchBar for ApexClass
    ClickElement                xpath=(//input[@type="search"])[2]
    WriteText                   alasree
    VerifyText                  No metadata components found matching your search criteria.
    ClickElement                xpath=(//input[@type="search"])[2]
    ClickText                   Clear
    WriteText                   ALMController
    VerifyText                  ALMController
    # Scroll                    //html                      page_down
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down
    Scroll                      //html                      down                        1500
Searchbar For Users
    ClickElement                xpath=(//input[@type="search"])[3]
    WriteText                   OrgId__c----fcgvhbjn
    # Scroll                    //html                      page_up
    VerifyText                  No users found matching your search criteria.
    # VerifyText                No custom settings found matching your search criteria.
    ClickElement                xpath=(//input[@type="search"])[3]
    ClickText                   Clear
    ClickElement                xpath=(//input[@type="search"])[3]
Serchbar for Custom_settings
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        100
    ClickElement                xpath=(//input[@type="search"])[4]
    WriteText                   OrgId__c
    # Scroll                    //html                      page_up
    # VerifyText                No users found matching your search criteria.
    # VerifyText                No custom settings found matching your search criteria.
    ClickElement                xpath=(//input[@type="search"])[4]
    ClickText                   Clear
    ClickElement                xpath=(//input[@type="search"])[4]
Searchbar For ScheduledJobs
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        1500
    Scroll                      //html                      down                        100
    ClickElement                xpath=(//input[@type="search"])[5]
    WriteText                   sample
    ClickText                   clear
SCREEN 2---SANDBOX REFRESH
    ClickText                   Next                        anchor=Edit Template
    ClickElement                xpath=//button[.//span[text()="Select an Org"]]
the select org is not wrk properly
MetadataRestore SCREEN
    ClickText                   Next                        anchor=Start Refresh
    ClickElement                xpath=//span[@title="Metadata"]
    ClickElement                xpath=//span[@title="Logs Information"]
    Scroll                      //html                      down                        100
    ClickText                   Execute                     anchor=Back
    VerifyText                  Deployment initiated successfully!
    sleep                       15s
    ClickItem                   Status
    sleep                       15s
    ClickItem                   Status
    VerifyText                  Deployment completed successfully.
    ClickElement                xpath=//span[@title="Metadata"]
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    Scroll                      //html                      down                        100
    ClickElement                xpath=//span[@title="Logs Information"]
    VerifyText                  LN-00
    VerifyText                  2025
    ClickText                   Next                        anchor=Execute
# Metadata Transformation Screen
#     # Scroll                    //html                      up                          100
#     # Scroll                    //html                      up                          100
#     # Scroll                    //html                      up                          100
#     Scroll                      //html                      down                        500
#     # VerifyText                ${ENV}
#     ClickElement                xpath=//span[@title="Search and Replace Rules"]
#     ClickElement                xpath=(//span[contains(@class, 'slds-file-selector__button')])[1]
#     # UploadFile                Upload Files                .xlsx
#     # ${uploadforSearchrules}                               Set Variable                C:\Users\alasree.b\Downloads\search13.csv
#     # UploadFile                Upload Files                ${uploadforSearchrules}
#     #                           ${relative_path}            Set Variable                Test/../Data/PO.pdf
#     ${uploadforSearchrules}     Set Variable                ${CURDIR}/Resources/../main/search13.csv

    pre-post screen
#     UploadFile                  Upload Files                ${uploadforSearchrules}

 # Verify file exists first
    # ${file_path}=               Normalize Path              ${CURDIR}/Resources/main/search13.csv
    # ${file_path}=               Normalize Path              ${CURDIR}/main/Resources/search13.csv
    # File Should Exist              ${file_path}
    # ${xpath_of_iploadfile}      xpath=(//span[contains(@class, 'slds-file-selector__text') and contains(@class, 'slds-medium-show')])[1]

    # ${uploadforSearchrules}=       Set Variable       ${CURDIR}/Resources/search13.csv
    # UploadFile                     ${xpath_of_iploadfile}         ${CURDIR}/Resources/search13.csv
#         # Set QWeb base path and use relative path
#         Set Variable                    $image_path         ${CURDIR}
#         ${uploadforSearchrules}=        Set Variable        search13.csv
#         File Should Exist              ${CURDIR}${/}${uploadforSearchrules}
#         UploadFile                      Upload Files        ${uploadforSearchrules}


#         # https://github.com/alasree/Copado-Robotic-Testing_2025-/blob/main/Resources/search13.csv

DataRestore Screen
    ClickElement        xpath=//span[@title="Users Information"]
    ClickElement    xpath=(//input[@data-navigation="enable"])[3]
    VerifyText      Selected Users
    Scroll                      //html                      down                        100        
    VerifyText      Total Records: 1
Custom Settings
    ClickElement        xpath=//span[@title="Custom Settings Information"]
    ClickElement        xpath=(//input[@type="search"])[2]
    WriteText           Org
    ClickText           Clear
    ClickElement        xpath=(//select[@class="slds-select"])[3]
Scheduled Jobs
    ClickElement    xpath=//span[@title="Schedule Jobs Information"]
    Scroll                      //html                      up                        500 
    ClickElement                xpath=(//input[@type="search"])[3]
    WriteText                   ala
    VerifyText                  No schedule jobs found matching your search criteria.
DeleteScheduledJobs
    clickElement    xpath=//span[@title="Delete Schedule Jobs Information"]
    VerifyText      Do you want to delete the Scheduled Jobs, Report Run, and Report Notifications that were copied from the source organization to the target after the sandbox refresh? If yes, click the Execute button and select the 'Delete Scheduled Jobs' checkbox.
    ClickText       Logs Information
    ClickText       Execute
    VerifyText      Select Items to Execute
    VerifyText      Users (Select at least one user using 'Cherry Pick' to enable this option.)
    ClickText       Cancel
    ClickText       Users Information
    ClickElement    xpath=//span[text()='Select Item 2']/ancestor::td
    ClickText       Execute
    # ClickText       Users
    ClickElement    xpath=//span[normalize-space(text())='Users']
    ClickElement    xpath=//span[normalize-space(text())='Custom Settings' and contains(@class, 'slds-form-element__label')]
# <span part="label" lwc-16hle61jt7i="" class="slds-form-element__label">Delete Schedule Jobs</span>
    ClickElement   xpath=//span[normalize-space(text())='Delete Schedule Jobs']
    ClickElement   xpath=//span[normalize-space(text())='Schedule Jobs']
    ClickText      Execute
    VerifyText     Execution started. Please wait. Refresh icon will appear after logs are generated.
    VerifyText     Logs are being generated. Please stay on this page—refresh icon will appear soon.
    RefreshPage
    ClickText      Next    anchor=Edit Template
    ClickText      Next    anchor=Start refresh
    ClickText      Next    anchor=Execute
    ClickText      Next    anchor=Execute
    ClickText      Status
    GetText     Custom Settings Restoration
    GetText     User Restoration
     ClickText      Status
     VerifyText     Custom Settings Restoration
     ClickText      Logs Information
     VerifyText     Users
     VerifyText     LN-00
     GetText     Custom Settings
     VerifyText     An Email is triggered on the execution of Schedule jobs and Deleted Scheduled jobs with respective status.
     ClickText      Next    anchor=Execute
     VerifyText     Data Transformation
     ClickElement    xpath=//button[@name="selectObjectList"]  
      Scroll                      //html                      down                        100       
      Scroll                      //html                      down                        500 
      HotKey                      down
      VerifyText                   Contact


















    





























SandboxRefresh



















