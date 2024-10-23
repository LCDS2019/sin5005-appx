RSpec.feature "Supplier Deletion", type: :feature, js: true do
  let!(:supplier) do
    Supplier.create!(
      code: 'SUP001',
      name: 'Supplier One',
      cnpj: '11111111111111',
      phone: '(11) 1234-5678',
      email: 'supplier1@test.com',
      segment: 'Segment A',
      products: 'Product A'
    )
  end

  scenario "User confirms deletion of a supplier" do
    visit suppliers_path

    expect(page).to have_content(supplier.name)
    click_button "Excluir"
    page.accept_confirm "Você tem certeza que deseja excluir este fornecedor?"
    expect(page).to have_content("Supplier was successfully deleted.")
    expect(Supplier.exists?(supplier.id)).to be_falsey
  end

  scenario "User cancels deletion of a supplier" do
    visit suppliers_path
    expect(page).to have_content(supplier.name)
    click_button "Excluir"
    page.dismiss_confirm "Você tem certeza que deseja excluir este fornecedor?"
    expect(page).to have_content(supplier.name)
    expect(Supplier.exists?(supplier.id)).to be_truthy
  end
end
