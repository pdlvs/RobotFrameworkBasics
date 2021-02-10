*** Settings ***
Resource        ../resources/Resource.robot
Test Setup      Abrir Navegador
Test Teardown   Fechar Navegador
*** Variables ***
${URL}      http://automationpractice.com
${BROWSER}  chrome
*** Test Case ***
Caso de Teste 01: Pesquisar produto existente
    Acessar página home do site
    Digitar o nome de produto "Blouse" no campo de pesquisa.
    Clicar no botão de pesquisa.
    Conferir se o produto "Blouse" foi listado no site.

Caso de Teste 02: Pesquisar produto não existente
    Acessar página home do site
    Digitar o nome de produto "produtoNãoExistente" no campo de pesquisa.
    Clicar no botão de pesquisa.
    Conferir mensagem de erro "No results were found for your search "produtoNãoExistente""
