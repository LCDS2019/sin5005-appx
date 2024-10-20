#language: pt

Funcionalidade: Editar Produto
  Como um funcionário da pizzaria
  eu quero consiguir editar os dados de um produto (Nome, Preço, Categoria, Requer Ingrediente)
  de forma que eu consiga atualizar os dados de um produto ofertado

  Cenário: editar um produto com dados válidos
    Dado que possuo alguns ingredientes cadastrados:
      | name       | unityMeasure  | quantityStock  | quantityStockMin   | quantityStockMax   |
      | Queijo     | kg            | 10             | 20                 | 1000               |
      | Pepperoni  | unity         | 100            | 10                 | 1500               |
    E que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no botão editar
    E atualizo as informações do produto ("Nome do produto", "Preço", "Categoria") para ("Água", 1.99, "Bebidas")
    E clico no botão "Salvar"
    Então devo ver as informações novas do produto ("Água", 1.99, "Bebidas", "false")

  Cenário: editar um produto com dados inválidos
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no botão editar
    E atualizo as informações do produto ("Nome do produto", "Preço", "Categoria") para ("", "", "")
    E clico no botão "Salvar"
    Então devo ver os erros de edição de produto "Name can't be empty", "Price can't be empty", "Price is not a number", "Category can't be empty"

  Cenário: editar um produto com preço inválido
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no botão editar
    E atualizo as informações do produto ("Nome do produto", "Preço", "Categoria") para ("Água", 0.00, "Bebidas")
    E clico no botão "Salvar"
    Então devo ver o erro de edição de produto "Price must be greater than 0"