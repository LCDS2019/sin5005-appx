
require 'rails_helper'

RSpec.describe "suppliers/show.html.erb", type: :view do
  let(:supplier) { create(:supplier) }

  before do
    assign(:supplier, supplier)
    render
  end

  it "displays the supplier's information" do
    expect(rendered).to have_selector("h1", text: "Informações do fornecedor")

    expect(rendered).to have_selector("strong", text: "Nome:")
    expect(rendered).to have_content(supplier.name)

    expect(rendered).to have_selector("strong", text: "CNPJ:")
    expect(rendered).to have_content(supplier.cnpj)

    expect(rendered).to have_selector("strong", text: "Telefone:")
    expect(rendered).to have_content(supplier.phone)

    expect(rendered).to have_selector("strong", text: "Email:")
    expect(rendered).to have_content(supplier.email)

    expect(rendered).to have_selector("strong", text: "Segmento:")
    expect(rendered).to have_content(supplier.segment)

    expect(rendered).to have_selector("strong", text: "Produtos:")
    expect(rendered).to have_content(supplier.products)
  end

  it "has a button to delete the supplier" do
    expect(rendered).to have_button('Excluir', disabled: false)
  end

  it "has a link to edit the supplier" do
    expect(rendered).to have_link('Editar', href: edit_supplier_path(supplier))
  end

  it "has a link to return to the supplier list" do
    expect(rendered).to have_link('Retornar para a lista de fornecedores', href: suppliers_path)
  end

  context "when flash messages are present" do
    context "when flash notice is present" do
      before do
        flash[:notice] = "Fornecedor foi excluído com sucesso."
        render
      end

      it "displays the success message" do
        expect(rendered).to have_selector("div.alert.alert-success", text: "Fornecedor foi excluído com sucesso.")
      end
    end

    context "when the user cancels the deletion" do
      before do
        flash[:notice] = nil
        render
      end

      it "does not set a flash message" do
        expect(rendered).not_to have_selector("div.alert.alert-success")
      end
    end
 end
end
