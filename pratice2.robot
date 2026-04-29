*** Settings ***
Library          Browser
Documentation    สคริปต์แก้ไขสำหรับการทดสอบ Exception Case บนเว็บ TestSheepNZ
Test Setup       Open Calculator Website
Test Teardown    Close Browser

*** Variables ***
${URL}           https://testsheepnz.github.io/BasicCalculator.html
${BROWSER}       chromium

*** Test Cases ***
TC-01 First and Second Number are not 'number'
    [Documentation]    กรอกตัวอักษรทั้งสองช่อง ระบบต้องไม่แสดงคำตอบและขึ้น Error
    Calculate And Verify Error    abc    def    Number 1 is not a number

TC-02 First Number is not 'number'
    [Documentation]    กรอกตัวอักษรช่องแรกช่องเดียว
    Calculate And Verify Error    abc    10     Number 1 is not a number

TC-03 Second Number is not 'number'
    [Documentation]    กรอกตัวอักษรช่องที่สองช่องเดียว
    Calculate And Verify Error    5      def    Number 2 is not a number

*** Keywords ***
Open Calculator Website
    New Browser    browser=${BROWSER}    headless=false
    New Page       ${URL}
    Select Options By    id=selectBuild    text    Prototype

Calculate And Verify Error
    [Arguments]    ${num1}    ${num2}    ${expected_error}
    Fill Text      id=number1Field    ${num1}
    Fill Text      id=number2Field    ${num2}
    Select Options By    id=selectOperationDropdown    text    Add
    Click          id=calculateButton
    
    Get Property    id=numberAnswerField    value    ==    ${EMPTY}
    
    Get Text       id=errorMsgField    contains    ${expected_error}