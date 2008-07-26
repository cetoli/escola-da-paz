class CursoController < ApplicationController
  layout "escola_paz"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @curso_pages, @cursos = paginate :cursos, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @curso = Curso.find(params[:id])
  end

  def new
    @curso = Curso.new
  end

  def create
    begin
      @curso = Curso.new(params[:curso])
      if @curso.save
        flash[:message] = 'Curso criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do curso n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do curso n�o efetuado. Erro: 'Curso j� existe'..."
      render :action => 'new'
    end
  end

  def edit
    @curso = Curso.find(params[:id])
  end

  def update
    @curso = Curso.find(params[:id])
    if @curso.update_attributes(params[:curso])
      flash[:message] = 'Curso alterado com sucesso!'
      redirect_to :action => 'show', :id => @curso
    else
      flash[:warning] = "Problemas na altera��o do curso..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      Curso.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de curso n�o efetuada. Erro: 'Curso est� sendo usado por algum usu�rio. Remova esta refer�ncia antes de excluir o curso'..."
    else
      flash[:message] = 'Curso exclu�do com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
