*** Settings ***
Library           Browser
Suite Setup       Open Parking Price Calculator Page
Test Template     Calculate Parking Price Template

*** Variables ***
${URL}                   https://practice.expandtesting.com/webpark
${PARKING_LOT_SELECT}    id=parkingLot
${ENTRY_DATE}            id=entryDate
${ENTRY_TIME}            id=entryTime
${EXIT_DATE}             id=exitDate
${EXIT_TIME}             id=exitTime
${CALCULATE_BTN}         xpath=//button[contains(text(), 'Calculate')]   
${RESULT_PRICE}          id=resultValue

*** Test Cases ***                                ENTRY_D       ENTRY_T    EXIT_D        EXIT_T    EXPECTED
TC-01 Under 1 hour    Long-Term Garage Parking    2026-05-01    10:00      2026-05-01    10:30     2.00€
TC-02 Per hour        Long-Term Garage Parking    2026-05-01    10:00      2026-05-01    11:00     2.00€
TC-03 Per day         Long-Term Garage Parking    2026-05-01    10:00      2026-05-02    10:00     12.00€
TC-04 Per week        Long-Term Garage Parking    2026-05-01    10:00      2026-05-08    10:00     72.00€

*** Keywords ***
Open Parking Price Calculator Page
    New Browser   browser=chromium    headless=False
    New Page       ${URL}   
    Set Browser Timeout    20 seconds


Calculate Parking Price Template
    [Arguments]    ${parking_type}    ${entry_d}    ${entry_t}    ${exit_d}    ${exit_t}    ${expected}
    
    
    
    Select Options By    ${PARKING_LOT_SELECT}    label    ${parking_type}
    
  
    Fill Text    ${ENTRY_DATE}    ${entry_d}
    Fill Text    ${ENTRY_TIME}    ${entry_t}
    Fill Text    ${EXIT_DATE}     ${exit_d}
    Fill Text    ${EXIT_TIME}     ${exit_t}
    
    Click        ${CALCULATE_BTN}
    
    Get Text     ${RESULT_PRICE}    contains    ${expected}

    Sleep       1s