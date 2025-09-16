***Settings***
Resource                   ../Resources/Variables.robot
Resource                   ../Resources/Common.robot
# Library                    DataDriver                  reader_class=TestDataApi    name=Account Creation.xlsx
Library                    QForce
Library                    DateTime
Library                    QWeb
Library                    String

*** Variables ***
# ${NoMetadataMsg}           No data available for the selected metadata type in the org.
***Keywords***
Selection of Org Retreival
    [Documentation]        Login to Salesforce instance. Takes instance_url, username and password as
    ...                    arguments. Uses values given in Copado Robotic Testing's variables section by default.
    [Arguments]            ${sf_instance_url}=${login_url}                         ${sf_username}=${username}                         ${sf_password}=${password}
    ClickText              Select an Org

    # Step 2: Loop through available environments and check for authentication
    FOR                    ${ENV}                      IN                          @{REFRESH_ENVIRONMENTS}
        Log                ${ENV}
        ClickText          ${ENV}

        ${actual_error}=                               GetText                     The org selected is not authenticated. Please authenticate it.
        # Log To Console     ${actual_error}

        IF                 '${actual_error}' != '${AUTH_ERROR_MSG}'
            Log To Console                             ${actual_error}
            Set Global Variable                        ${ENV}
            Exit For Loop
        END

        ClickText          ${ENV}
        Sleep              3s
    END
Metadata Retreival

    FOR                    ${Metadata_Type}            IN                          @{Metadata_Types}

        Log To Console     ${Metadata_Type}
        ClickText          ${SelectMetadata}           timeout=10s
        ClickText          ${Metadata_Type}            timeout=40s

        Sleep              3s
        ${data_exists}=    Run Keyword And Return Status                           VerifyText                  Search Metadata Components    timeout=3s
        IF                 ${data_exists}
            # Click Checkbox                             Select All                  on                          index=1                timeout=20s
            Click Checkbox     Select All                  on                          index=1    timeout=20s
        

            # ClickText    Next                        anchor=Last
            # Click Checkbox                           Select All                  on                          index=1                timeout=20s
        ELSE
            Log To Console                             do nothing
        END


    END
    
Selecting the Masking Type
    ClickElement           xpath=//button[@name="selectMaskingType"]
    ClickText              Search & Replace
    ClickElement           xpath=//div[@data-value="AuthProvider"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="CustomLabel"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="CustomMetadata"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="NamedCredential"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="RemoteSiteSetting"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="WorkflowAlert"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//input[@placeholder="Type the value..."]
    Write Text             Login
    ClickElement           xpath=//input[@placeholder="Type the value you want to replace with..."]
    Write Text             test
    ClickElement           xpath=//button[@title="Create Rule"]
    ${Success_message}=    GetText                     6 rules created successfully
    Log To Console         ${Success_message}=   
Select the Suffix Masking
    ClickElement           xpath=//button[@name="selectMaskingType"]
    ClickText              Suffix
    # ClickElement           xpath=//div[@data-value="CustomLabel"]
    ClickElement           xpath=//span[@title="Custom Labels"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="ConnectedApp"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="CustomMetadata"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    # sleep                  30s
    ClickElement           xpath=//div[@data-value="EmailServicesFunction"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//div[@data-value="WorkflowAlert"]
    ClickElement           xpath=//button[@title="Move to Selected"]
    ClickElement           xpath=//input[@placeholder="Enter the suffix value..."]
    WriteText              .invalid
    ClickElement           xpath=//button[@title="Create Rule"]
    ClickElement           xpath=//button[@name="selectMaskingType"]