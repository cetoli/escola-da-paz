class ArquivoController < ApplicationController
  layout "escola_paz"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @arquivo_pages, @arquivos = paginate :arquivos, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @arquivo = Arquivo.find(params[:id])
  end

  def new
    @arquivo = Arquivo.new
  end

  def create
    begin
      @arquivo = Arquivo.new(params[:arquivo])
      if @arquivo.save
        flash[:message] = 'Tipo de Arquivo criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do tipo de arquivo n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do tipo de arquivo n�o efetuado. Erro: 'Tipo de Arquivo j� existe'..."
      render :action => 'new'
    end
  end

  def edit
    @arquivo = Arquivo.find(params[:id])
  end

  def update
    @arquivo = Arquivo.find(params[:id])
    if @arquivo.update_attributes(params[:arquivo])
      flash[:message] = 'Tipo de Arquivo alterado com sucesso!'
      redirect_to :action => 'show', :id => @arquivo
    else
      flash[:warning] = "Problemas na altera��o do tipo de arquivo..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      Arquivo.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de tipo de arquivo n�o efetuada. Erro: 'Tipo de Arquivo est� sendo usado por algum item na biblioteca. Remova esta refer�ncia antes de excluir o tipo de arquivo'..."
    else
      flash[:message] = 'Tipo de Arquivo exclu�do com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
