*** Settings ***
Library           Browser
Library           CSVLibrary
Suite Setup       Open Register Page
Suite Teardown    Close Browser


*** Variables ***
${CSV_FILE}       C:/Users/iTservice/OneDrive/เอกสาร/pratice_Automate/result/dataset/test.csv
${URL}            https://practice.expandtesting.com/notes/app/register

*** Test Cases ***
Verify All Register Exceptions From CSV
    [Documentation]    รัน Exception Cases โดยครอบคลุม Name และ Confirm Password
    ${data}=    Read Csv File To List   ${CSV_FILE}
    
    FOR    ${row}    IN    @{data[1:]}
        Go To    ${URL}    
        
        
        Fill Text    id=name               ${row[0]}
        Fill Text    id=email              ${row[1]}
        Fill Text    id=password           ${row[2]}
        Fill Text    id=confirmPassword    ${row[3]}
        
        Click        css=button[type="submit"]
        
        Get Text     body    contains    ${row[4]}
        
        Log    Checked Case: ${row[4]}

        Sleep       1s
    END

*** Keywords ***
Open Register Page
    New Browser   browser=chromium    headless=False
    New Page       ${URL}   
    Set Browser Timeout    20 seconds