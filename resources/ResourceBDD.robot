*** Settings ***
Library         SeleniumLibrary
Library         String
Library         BuiltIn

*** Variables ***
${BROWSER}  chrome
${URL}      http://automationpractice.com
&{DADOS}    nome=Patricia sobrenome=Alves senha=TesteTeste endereço=Rua Londrina, Bairro Centro
...         cidade=Londrina cep=76706 celular=99556790 estado=3    

*** Keywords ***
###Setup e Teardown###
Abrir Navegador
    Open Browser    about:blank  ${BROWSER}
Fechar Navegador
    Close Browser

Gerar endereço de e-mail
    [Arguments]         ${NOME}
    ${STRING_GERADA}    Generate Random String
    ${USER_EMAIL}       Set Variable    ${NOME}${STRING_GERADA}@email.com 
    
    [Return]            ${USER_EMAIL} 

###Passo a passo###
Dado que estou na página home do site
    Go to            http://automationpractice.com/
    Title Should Be  My Store

Quando eu pesquisar pelo produto "${PRODUTO}"
    Input Text      id=search_query_top    ${PRODUTO}
    Click Button    name=submit_search

Então o produto "${PRODUTO}" deve ser listado na página de resultado da busca
     Wait until Element Is Visible   css=#center_column > h1
     Title Should Be                 Search - My Store
     Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/7/7-home_default.jpg']
     Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(), "${PRODUTO}")]

Então a página deve exibir a mensagem "${MENSAGEM_ALERTA}"
     Wait until Element Is Visible    xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
     Element Text Should Be           xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]    ${MENSAGEM_ALERTA}

Quando eu acessar a categoria "${CATEGORIA}"
    Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]
    Mouse Over                      xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]

E consultar a sub-categoria "${SUB_CATEGORIA}"
    Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]//a[@title="${SUB_CATEGORIA}"]
    Click Element                   xpath=//*[@id="block_top_menu"]//a[@title="${SUB_CATEGORIA}"]

Então a página deve exibir os produtos da sub-categoria "${SUB_CATEGORIA}"
    @{DRESSES}  Create List     Printed Summer Dress    Printed Summer Dress    Printed Chiffon Dress
    Wait until Element Is Visible  xpath=//*[@id="center_column"]/h1/span[1][@class="cat-name"]
    Page Should Contain Element    xpath=//*[@id="center_column"]/h1/span[contains(text(),"${SUB_CATEGORIA}")]
    Page Should Contain Element    xpath=//*[@id="center_column"]/ul/li[1]/div/div[2]/h5/a[@title="${DRESSES[0]}"]
    Page Should Contain Element    xpath=//*[@id="center_column"]/ul/li[2]/div/div[2]/h5/a[@title="${DRESSES[1]}"]
    Page Should Contain Element    xpath=//*[@id="center_column"]/ul/li[3]/div/div[2]/h5/a[@title="${DRESSES[2]}"]

E Clicar no botão "Add to cart"
    Wait until element is visible    xpath=//*[@id="center_column"]//a[@title="Add to cart"]
    Click Element                    xpath=//*[@id="center_column"]//a[@title="Add to cart"]

E exibir a tela de confirmação
    Wait until element is visible   xpath=//*[@id="layer_cart"]
    Page Should Contain Element     xpath=//*[@id="layer_cart"]

E Clicar no botão "Proceed to checkout" do produto
    Wait Until Element Is Visible   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
    Click Element                   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

Então A tela do carrinho de compras deve ser exibido, com os dados do produto e valores.
    Wait until element is visible   css=#cart_title
    Title Should Be                 Order - My Store
    Page Should Contain Element     id=order-detail-content

E existe o produto "${PRODUTO}" adicionado no carrinho
    Quando eu pesquisar pelo produto "${PRODUTO}"
    E Clicar no botão "Add to cart"
    E Clicar no botão "Proceed to checkout" do produto

Quando excluir o produto do carrinho
    Click Element    xpath=//*[@class="cart_quantity_delete"]

Então a página deverá exibir a mensagem "${MENSAGEM}"
     Wait until Element Is Visible   xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
     Element Text Should Be          xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]    ${MENSAGEM}

Quando eu Clicar no botão superior direito “Sign in"
    Click Element                   xpath=//*[@id="header"]//a[@class="login"]

E inserir um e-mail válido
    Wait until Element Is Visible   id=email_create
    ${EMAIL}                        Gerar endereço de e-mail    ${DADOS.nome}
    Input Text                      id=email_create    ${EMAIL}

E Clicar no botão "Create an account"
    Click Button    id=SubmitCreate

E Preencher os campos obrigatórios.
    Wait Until Element Is Visible   xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
    Click Element                   id=id_gender2
    Input Text                      id=customer_firstname    ${DADOS.nome}
    Input Text                      id=customer_lastname     ${DADOS.sobrenome}
    Input Text                      id=passwd                ${DADOS.senha}
    Input Text                      id=address1              ${DADOS.endereco}
    Input Text                      id=city                  ${DADOS.cidade}
    Set Focus To Element            id=id_state
    Select From List By Index       id=id_state              ${DADOS.cidade}
    Input Text                      id=postcode              ${DADOS.cep}
    Input Text                      id=phone_mobile          ${DADOS.celular}

E Clicar em "Register" para finalizar o cadastro.
    Click Button    submitAccount

Então a página de gerenciamento da conta deve ser exibida.
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]/p
    Element Text Should Be           xpath=//*[@id="center_column"]/p
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           xpath=//*[@id="header"]/div[2]//div[1]/a/span    Patricia Alves