*** Settings ***
Library         SeleniumLibrary
Library         String

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

Quando eu Passar o mouse por cima da categoria "${CATEGORIA}" no menu principal superior de categorias
     Wait until Element Is Visible  xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]
     Mouse Over                     xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]

E Clicar na sub-categoria "${SUB_CATEGORIA}"
    Click Link                      xpath=//*[@id="block_top_menu"]//a[@href='${URL}/index.php?id_category=11&controller=category']

Então Uma página com os produtos da sub-categoria "${SUB_CATEGORIA}" deve ser exibida.
    Wait until element is visible   css=#center_column > h1 > span.cat-name
    Title Should Be                 Summer Dresses - My Store

E Clicar no botão "Add to cart"
    Wait until element is visible    xpath=//*[@id="center_column"]//a[@title="Add to cart"]
    Click Element                    xpath=//*[@id="center_column"]//a[@title="Add to cart"]

E exibir a tela de confirmação
    Wait until element is visible   xpath=//*[@id="layer_cart"]
    Page Should Contain Element     xpath=//*[@id="layer_cart"]

E Clicar no botão "Proceed to checkout" do produto
    Wait until element is visible   xpath=//*[@id="layer_cart"]//a
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
    ${EMAIL}                        Generate Random String
    Input Text                      id=email_create    ${EMAIL}@email.com

E Clicar no botão "Create an account"
    Click Button    id=SubmitCreate

E Preencher os campos obrigatórios.
    Wait Until Element Is Visible   xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
    Click Element                   id=id_gender2
    Input Text                      id=customer_firstname    Patricia
    Input Text                      id=customer_lastname     Alves
    Input Text                      id=passwd                TesteTeste
    Input Text                      id=address1              Rua Londrina, Bairro Centro
    Input Text                      id=city                  Londrina
    Set Focus To Element            id=id_state
    Select From List By Index       id=id_state              3
    Input Text                      id=postcode              76706
    Input Text                      id=phone_mobile          99556790

E Clicar em "Register" para finalizar o cadastro.
    Click Button    submitAccount

Então a página de gerenciamento da conta deve ser exibida.
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]/p
    Element Text Should Be           xpath=//*[@id="center_column"]/p
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           xpath=//*[@id="header"]/div[2]//div[1]/a/span    Patricia Alves