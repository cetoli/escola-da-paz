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
        flash[:warning] = "Cadastramento do curso não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do curso não efetuado. Erro: 'Curso já existe'..."
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
      flash[:warning] = "Problemas na alteração do curso..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      Curso.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de curso não efetuada. Erro: 'Curso está sendo usado por algum usuário. Remova esta referência antes de excluir o curso'..."
    else
      flash[:message] = 'Curso excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
