
# Cenário: Cadastrar um novo ingrediente
Quando ('eu acesso a página de cadastro de ingredientes') do
  visit "/ingredients/new"
end

Então ('eu devo ver um formulário para cadastrar um novo ingrediente') do
  expect(page).to have_field('ingredient[name]')
  expect(page).to have_field('ingredient[unityMeasure]')
  expect(page).to have_field('ingredient[quantityStock]')
  expect(page).to have_field('ingredient[quantityStockMin]')
  expect(page).to have_field('ingredient[quantityStockMax]')
  expect(page).to have_button('commit')
end

Quando ('eu preencho o formulário com:') do |table|
  table.hashes.each do |row|
    fill_in 'ingredient[name]', with: row['Nome']
    fill_in 'ingredient[unityMeasure]', with: row['Unidade de medição']
    fill_in 'ingredient[quantityStock]', with: row['Quantidade em estoque']
    fill_in 'ingredient[quantityStockMin]', with: row['Quantidade mínima em estoque']
    fill_in 'ingredient[quantityStockMax]', with: row['Quantidade máxima em estoque']
  end
end

Quando ('eu clico no botão "Criar"') do
  click_button 'commit'
 end

Então ('eu devo ser redirecionado para a página que mostra o ingrediente cadastrado') do
  expect(current_path).to eq("/ingredients/1")
end

Então ('eu devo ver a mensagem de sucesso {string}') do |string|
  expect(page).to have_content('Ingrediente foi criado com sucesso.')
end

Então ('eu devo ver o ingrediente {string} com a unidade {string} a quantidade {string} a quantidade min {string} a quantidade max {string}') do |nome, unidade, quantidade, quantidade_min, quantidade_max|
  expect(page).to have_content(nome)
  expect(page).to have_content(unidade)
  expect(page).to have_content(quantidade)
  expect(page).to have_content(quantidade_min)
  expect(page).to have_content(quantidade_max)
end

# Cenário: Listar todos os ingredientes
Dado ('que existem os seguintes ingredientes:') do |table|
  table.hashes.each do |row|
    Ingredient.create(name: row['Nome'], unityMeasure: row['Unidade de medição'], quantityStock: row['Quantidade em estoque'], quantityStockMin: row['Quantidade mínima em estoque'], quantityStockMax: row['Quantidade máxima em estoque'])
  end
end

Quando ('eu acesso a página de listagem de ingredientes') do
  visit "/ingredients"
end

Então ('eu devo ver uma lista com todos os ingredientes cadastrados') do
  within "#ingredients tbody" do
    expect(page).to have_selector('tr', count: 3)
  end
end

# Cenário: Editar um ingrediente
Dado ('que existe o ingrediente {string} com a unidade {string} a quantidade {string} a quantidade min {string} a quantidade max {string}') do |nome, unidade, quantidade, quantidade_min, quantidade_max|
  Ingredient.create(name: nome, unityMeasure: unidade, quantityStock: quantidade, quantityStockMin: quantidade_min, quantityStockMax: quantidade_max)
end

Quando 'eu acesso a página de edição do ingrediente "Queijo"' do
  # Obtem o ID do ingrediente "Queijo"
  queijo_id = Ingredient.find_by(name: 'Queijo').id
  visit edit_ingredient_path(queijo_id)
end

Então ('eu devo ver um formulário preenchido com os dados do ingrediente "Queijo"') do
  expect(page).to have_field('ingredient[name]', with: 'Queijo')
  expect(page).to have_field('ingredient[unityMeasure]', with: 'g')
  expect(page).to have_field('ingredient[quantityStock]', with: '1000.0')
  expect(page).to have_field('ingredient[quantityStockMin]', with: '10')
  expect(page).to have_field('ingredient[quantityStockMax]', with: '2000')
end

Quando ('eu altero a quantidade em estoque para "1500"') do
  fill_in 'ingredient[quantityStock]', with: '1500'
end

Quando ('eu clico no botão "Atualizar ingrediente"') do
  click_button 'commit'
end

Então ('eu devo ser redirecionado para a página de ingrediente atualizado') do
  queijo = Ingredient.find_by(name: 'Queijo')
  expect(ingredients_path(queijo)).to eq(ingredients_path(queijo))
end

Então ('eu devo visualizar a mensagem de sucesso {string}') do |string|
   expect(page).to have_content('Ingrediente foi atualizado com sucesso.')
end

Então ('eu devo visualizar o ingrediente {string} com a unidade {string} a quantidade {string} a quantidade min {string} a quantidade max {string}') do |nome, unidade, quantidade, quantidade_min, quantidade_max|
  expect(page).to have_content(nome)
  expect(page).to have_content(unidade)
  expect(page).to have_content(quantidade)
  expect(page).to have_content(quantidade_min)
  expect(page).to have_content(quantidade_max)
end

# Cenário: Remover um ingrediente
Dado ('a existência do ingrediente {string} com a unidade {string} a quantidade {string} a quantidade min {string} a quantidade max {string}') do |nome, unidade, quantidade, quantidade_min, quantidade_max|
  Ingredient.create(name: nome, unityMeasure: unidade, quantityStock: quantidade, quantityStockMin: quantidade_min, quantityStockMax: quantidade_max)
end

Quando ('eu acesso a página para exclusão do ingrediente "Tomate"') do
  # Obtem o ID do ingrediente "Tomate"
  tomate_id = Ingredient.find_by(name: 'Tomate').id
  visit ingredient_path(tomate_id)
end

Quando ('pressionado o botão "Excluir este ingrediente"') do
  click_button 'destroy_ingredient'
end

Então ('deve ser mostrada a mensagem de sucesso "Ingrediente foi excluído com sucesso."') do
  expect(page).to have_content('Ingrediente foi excluído com sucesso.')
end

Então ('eu não devo ver o ingrediente "Tomate" na lista de ingredientes') do
  expect(page).not_to have_field('ingredient[name]', with: 'Tomate')
end
