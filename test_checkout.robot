*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}              https://www.saucedemo.com/
${USERNAME}         standard_user
${PASSWORD}         secret_sauce
${PRODUCT_NAME}     Sauce Labs Fleece Jacket
${FIRST_NAME}       Aishwarya
${LAST_NAME}        S
${POSTAL_CODE}      600001

*** Test Cases ***
Search And Checkout Product
    [Documentation]    Automate login → search → add to cart → checkout → print payment info
    Open Browser To Login Page
    Login With Valid Credentials
    Search And Open Product
    Add Product To Cart
    Go To Cart And Checkout
    Enter Checkout Information
    Print Payment And Total Info
    Finish Order
    Verify Order Completion
    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

Login With Valid Credentials
    Input Text    id:user-name    ${USERNAME}
    Input Text    id:password     ${PASSWORD}
    Click Button  id:login-button
    Wait Until Page Contains Element    class:inventory_item

Search And Open Product
    Click Element    xpath://div[text()='${PRODUCT_NAME}']

Add Product To Cart
    Click Button    xpath://button[contains(@id, 'add-to-cart')]

Go To Cart And Checkout
    Click Element    class:shopping_cart_link
    Click Button     id:checkout

Enter Checkout Information
    Input Text    id:first-name    ${FIRST_NAME}
    Input Text    id:last-name     ${LAST_NAME}
    Input Text    id:postal-code   ${POSTAL_CODE}
    Click Button  id:continue

Print Payment And Total Info
    ${payment}=    Get Text    xpath://div[@class='summary_value_label'][1]
    ${total}=      Get Text    class:summary_total_label
    Log To Console    \nPayment Information: ${payment}
    Log To Console    Total Price: ${total}

Finish Order
    Click Button    id:finish

Verify Order Completion
    Page Should Contain    Thank you for your order!
