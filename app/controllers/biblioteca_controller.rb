class BibliotecaController < ApplicationController
  layout "escola_paz"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getBiblioteca', 'list']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :getBiblioteca],
         :redirect_to => { :action => :list }

  def list
    @biblioteca_pages, @bibliotecas = paginate :bibliotecas, :per_page => numberOfPages, :order => "titulo"
  end

  def new
    @biblioteca = Biblioteca.new
    @arquivos = Arquivo.find(:all).collect{ |t| [t.nome, t.id] }
  end

  def create
    begin
      @biblioteca = Biblioteca.new(params[:biblioteca])
      if @biblioteca.save
        flash[:message] = 'Arquivo criado com sucesso!'
        redirect_to :action => 'list'
      else
        @arquivos = Arquivo.find(:all).collect{ |t| [t.nome, t.id] }
        flash[:warning] = "Cadastramento do arquivo não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      @arquivos = Arquivo.find(:all).collect{ |t| [t.nome, t.id] }
      flash[:warning] = "Cadastramento do arquivo não efetuado. Erro: 'Erro no Banco de Dados'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Biblioteca.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de arquivo não efetuada. Erro: 'Erro no Banco de Dados'..."
    else
      flash[:message] = 'Arquivo excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end

  def getBiblioteca
    @biblioteca = Biblioteca.find(params[:id])
    send_data(@biblioteca.anexo, :filename => "#{@biblioteca.nome}")
  end
end
