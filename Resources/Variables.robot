*** Variables ***

# Table Elements
# ${SELECT_ALL_CHECKBOX}    xpath=//lightning-datatable//thead/tr/th[1]//input[@type='checkbox']
${SELECT_ALL_CHECKBOX}      xpath=(//lightning-datatable//thead/tr/th[1]//input[@type='checkbox'])[1]
# //span[text()="Select All"]

# Buttons
${SELECT_MASKING_BTN}       xpath=//button[@name="selectMaskingType"]
${SELECT_DATA_BTN}          xpath=//button[@name="selectData"]


@{REFRESH_ENVIRONMENTS}     BiswaDev      refreshqa1            refreshqa4
${AUTH_ERROR_MSG}           The org selected is not authenticated. Please authenticate it.
${ERROR_MSG}
${actual_error}             Null
${OUTPUT_DIR}               ${EXECDIR}/output

${FILENAME}                 ${OUTPUT_DIR}/template_name.txt
# @{Metadata_Types}          AIApplication               ActionLauncherItemDef                       ApexClass        ApexComponent    ApexTrigger    ObjectSourceTargetMap
${SelectMetadata}           xpath=//*[@name="selectMetadata"]
@{Metadata_Types}           ApexClass
${NoMetadataMsg}            No data available for the selected metadata type in the org.
${Metadata_Type}
${SelectedMetadata}
${Search Key}               login
${Replace Value}            test
# ${DeSELECT_ALL_CHECKBOX}                              xpath=(//span[@class="slds-form-element__label slds-assistive-text" and text()="Select All"])[1]

${DeSELECT_ALL_CHECKBOX}    xpath=(//lightning-datatable//thead/tr/th[1]//input[@type='checkbox'])[2]
@{ApexClasses_refqa2}       ApexBatchClass              BatchApexTestClass    BatchArchviedClass
@{ApexClasses_refqa2_edittemplate}                      ApexBatchClass        BatchApexTestClass    BatchArchviedClass

@{Metadata_Masking}         Search & Replace            Suffix                Apex Script
${AccountCreation}          Account a = new Account();a.Name='TestingCRT';a.sales_owner__c = 'shalini';insert a;
@{Custom_settings}          Select Item 1               Select Item 2         Select Item 3         Select Item 4    Select Item 5
@{xpath_for_searchApexclass}        xpath=//label[normalize-space(text())="Search Metadata"]/following-sibling::div//input[@type="search"]        
@{xpath_for_searchUsers}            xpath=//label[normalize-space(text())="Search Users"]/following-sibling::div//input[@type="search"]
@{xpath_for_searchCustomSettings}    xpath=//label[normalize-space(text())="Search Custom Settings"]/following-sibling::div//input[@type="search"]
@{xpath_for_searchScheduledJobs}    xpath=//label[normalize-space(text())="Search Schedule Jobs"]/following-sibling::div//input[@type="search"]






