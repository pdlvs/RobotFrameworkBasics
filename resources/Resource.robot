*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${BROWSER}  chrome
${URL}      http://automationpractice.com

*** Keywords ***
###Setup e Teardown###
Abrir Navegador
    Open Browser    about:blank  ${BROWSER}
Fechar Navegador
    Close Browser

###Passo a passo###
Acessar página home do site
    Go to            http://automationpractice.com/
    Title Should Be  My Store

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa.
    Input Text      id=search_query_top    ${PRODUTO}

Clicar no botão de pesquisa.
    Click Button    name=submit_search

#### Conferências
Conferir se o produto "${PRODUTO}" foi listado no site.
    Wait until Element Is Visible   css=#center_column > h1
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/7/7-home_default.jpg']
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(), "${PRODUTO}")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait until Element Is Visible    xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
    Element Text Should Be           xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]    ${MENSAGEM_ALERTA}

