class ClientesController < ApplicationController
  def index
    if params[:search].present?
      @clientes = Cliente.where("nome LIKE ?", "%#{params[:search]}%")
    else
      @clientes = Cliente.all
    end

    @quantidade_clientes = @clientes.count

    if ActiveRecord::Base.connection.adapter_name == "SQLite"
      @clientes_mes_atual = @clientes.where("strftime('%m', data_nascimento) = ?", Date.today.strftime("%m")).count
    else
      @clientes_mes_atual = @clientes.where("DATE_PART('month', data_nascimento) = ?", Date.today.month).count
    end
  end

    def show
      @cliente = Cliente.find(params[:id])
    end

    def new
      @cliente = Cliente.new
    end

    def create
      @cliente = Cliente.new(cliente_params)
      if @cliente.save
        redirect_to clientes_path
      else
        render :new
      end
    end

    def edit
      @cliente = Cliente.find(params[:id])
    end

    def update
      @cliente = Cliente.find(params[:id])

      if @cliente.update(cliente_params)
        redirect_to clientes_path
      else
        render :edit
      end
    end

    def destroy
      @cliente = Cliente.find(params[:id])
      if @cliente.destroy
        redirect_to clientes_path
      else
        redirect_to clientes_path
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to clientes_path
    end

    private

    def cliente_params
      params.require(:cliente).permit(:nome, :telefone, :email, :endereco, :data_nascimento, :observacoes)
    end
end
