*** Settings ***
Resource        ../resources/ResourceBDD.robot
Test Setup      Abrir Navegador
Test Teardown   Fechar Navegador

*** Test Case ***
Cenário 01: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultado da busca

Cenário 02: Pesquisar produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "itemNãoExistente"
    Então a página deve exibir a mensagem "No results were found for your search "itemNãoExistente""

Cenário 03: Listar Produtos
    Dado que estou na página home do site
    Quando eu Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    E Clicar na sub-categoria "Summer Dresses"
    Então Uma página com os produtos da sub-categoria "Summer Dresses" deve ser exibida.

Cenário 04: Adicionar Produtos no Carrinho
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "t-shirt"
    E Clicar no botão "Add to cart"
    E exibir a tela de confirmação
    E Clicar no botão "Proceed to checkout" do produto
    Então A tela do carrinho de compras deve ser exibido, com os dados do produto e valores.

Cenário 05: Remover Produtos
    Dado que estou na página home do site
    E existe o produto "t-shirt" adicionado no carrinho
    Quando excluir o produto do carrinho
    Então a página deverá exibir a mensagem "Your shopping cart is empty."

Cenário 06: Adicionar Cliente
    Dado que estou na página home do site
    Quando eu Clicar no botão superior direito “Sign in"
    E inserir um e-mail válido
    E Clicar no botão "Create an account"
    E Preencher os campos obrigatórios.
    E Clicar em "Register" para finalizar o cadastro.
    Então a página de gerenciamento da conta deve ser exibida.

