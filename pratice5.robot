*** Settings ***
Library           Browser
Suite Setup       Open DataTables Page
Test Teardown     Clear Search Field

*** Variables ***
${URL}            https://datatables.net/examples/styling/stripe.html
${SEARCH_INPUT}   xpath=//input[@type='search']
${TABLE_ROWS}     xpath=//table[@id='example']/tbody/tr
${INFO_ID}        xpath=//*[@id='example_info']

*** Test Cases ***
Verify Full Search Lower Case
    Filter And Verify Position Data    software engineer

Verify Full Search Upper Case
    Filter And Verify Position Data    SOFTWARE ENGINEER

Verify Partial Search Start Word
    Filter And Verify Position Data    Sales

Verify Partial Search Middle Word
    Filter And Verify Position Data    Javascript

*** Keywords ***
Open DataTables Page
    New Browser    browser=chromium    headless=False
    New Page       ${URL}

Clear Search Field
    Fill Text      ${SEARCH_INPUT}    ${EMPTY}

Filter And Verify Position Data
    [Arguments]    ${search_term}
    
    Fill Text      ${SEARCH_INPUT}    ${search_term}
    
    ${row_count}=    Get Element Count    ${TABLE_ROWS}
    Log To Console    \nSearch Term: ${search_term} | Found: ${row_count} rows
    
    FOR    ${index}    IN RANGE    1    ${row_count} + 1
        ${cell_text}=    Get Text    xpath=//table[@id='example']/tbody/tr[${index}]/td[2]
        
        Log To Console    Checking Row ${index}: ${cell_text}
        
        Should Contain    ${cell_text}    ${search_term}    ignore_case=True
    END

    ${info_text}=    Get Text    ${INFO_ID}
    Should Contain    ${info_text}    Showing 1 to ${row_count} of ${row_count} entries