class PaperController < ApplicationController
  layout "escola_paz"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getArtsArea', 'getResumo', 'getAnexo', 'mostrar', 'novo', 'editar', 'updateUsr', 'createUsr']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :updateUsr, :createUsr, :getResumo, :getAnexo, :mostrar, :aprovar, :editar, :novo ],
         :redirect_to => { :action => :list }

  def list
    @paper_pages, @papers = paginate :papers, :per_page => numberOfPages, :order => "titulo"
  end

  def show
    @paper = Paper.find(params[:id])
  end

  def new
    @paper = Paper.new
    @users = User.find(:all).collect{ |t| [t.login, t.id] }
    @areas = Area.find(:all, :conditions => ['paper = :paper', {:paper => true}], :order => "codigo").collect{ |c| [c.codigo, c.id] }
    @show = true
  end

  def create
    begin
      @paper = Paper.new(params[:paper])
      @paper.criado = @paper.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @paper.aprovado = false
      if @paper.save
        flash[:message] = 'Artigo criado com sucesso!'
        Notifications.deliver_docApproval('adm.tuia@gmail.com', @paper.titulo, @paper.criado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.user.nome)
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do artigo não efetuado..."
        @users = User.find(:all).collect{ |t| [t.login, t.id] }
        @areas = Area.find(:all, :conditions => ['paper = :paper', {:paper => true}], :order => "codigo").collect{ |c| [c.codigo, c.id] }
        @show = true
        render :action => 'new'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'list'
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do artigo não efetuada. Erro: 'Erro no Banco de Dados'..."
      redirect_to :action => 'show', :id => @paper
    end
  end

  def edit
    @paper = Paper.find(params[:id])
    @areas = Area.find(:all, :conditions => ['paper = :paper', {:paper => true}], :order => "codigo").collect{ |c| [c.codigo, c.id] }
    @show = false
  end

  def update
    begin
      @paper = Paper.find(params[:id])
      @paper.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @paper.aprovado = false
      if @paper.update_attributes(params[:paper])
        flash[:message] = 'Artigo alterado com sucesso!'
        Notifications.deliver_docApproval('adm.tuia@gmail.com', @paper.titulo, @paper.criado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.user.nome)
        redirect_to :action => 'show', :id => @paper
      else
        flash[:warning] = "Alteração do artigo não efetuado..."
        render :action => 'edit'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'show', :id => @paper
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do artigo não efetuada. Erro: 'Erro no Banco de Dados'..."
      redirect_to :action => 'show', :id => @paper
    end
  end

  def destroy
    begin
      Paper.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de artigo não efetuada. Erro: 'Erro no Banco de Dados'..."
    else
      flash[:message] = 'Artigo excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end

  def aprovar
    @paper = Paper.find(params[:id])
    @paper.aprovado = true
    if @paper.save(false)
      flash[:message] = 'Artigo aprovado com sucesso!'
      redirect_to :action => 'show', :id => @paper
    else
      flash[:warning] = "Aprovação do artigo não efetuada..."
      render :action => 'show', :id => @paper
    end
  end

  def mostrar
    @paper = Paper.find(params[:id])
    @area = params[:area]
  end

  def novo
    @paper = Paper.new
    @user_id = current_user.id
    @area_id = params[:id]
    @area = params[:area]
  end

  def editar
    @paper = Paper.find(params[:id])
    @area = params[:area]
  end

  def updateUsr
    begin
      @paper = Paper.find(params[:id])
      @paper.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @paper.aprovado = false
      @area = params[:area]
      if @paper.update_attributes(params[:paper])
        flash[:message] = 'Artigo alterado com sucesso!'
        Notifications.deliver_docApproval('adm.tuia@gmail.com', @paper.titulo, @paper.criado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.user.nome)
        redirect_to :action => 'getArtsArea', :id => @paper.area
      else
        flash[:warning] = "Alteração do artigo não efetuada..."
        render :action => 'editar'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'getArtsArea', :id => @paper.area
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do artigo não efetuada. Erro: 'Erro no Banco de Dados'..."
      redirect_to :action => 'getArtsArea', :id => @paper.area
    end
  end

  def createUsr
    begin
      @paper = Paper.new(params[:paper])
      @paper.user_id = params[:user_id]
      @paper.area_id = params[:area_id]
      @paper.criado = @paper.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @paper.aprovado = false
      if @paper.save
        flash[:message] = 'Artigo criado com sucesso!'
        Notifications.deliver_docApproval('adm.tuia@gmail.com', @paper.titulo, @paper.criado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @paper.user.nome)
        redirect_to :action => 'getArtsArea', :id => @paper.area
      else
        flash[:warning] = "Cadastramento do artigo não efetuado..."
        @user_id = current_user.id
        @area_id = params[:area_id]
        @area = params[:area]
        render :action => 'novo'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'getArtsArea', :id => @paper.area
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do artigo não efetuada. Erro: 'Erro no Banco de Dados'..."
      redirect_to :action => 'show', :id => @paper
    end
  end

  def getArtsArea
    @paper_pages, @papers = paginate :papers, :conditions => { :area_id => params[:id], :aprovado => true }, :per_page => numberOfPages, :order => "titulo"
    @area = params[:area]
    @idArea = params[:id]
    render :action => 'listar'
  end

  def getAnexo
    @paper = Paper.find(params[:id])
    send_data(@paper.anexo, :filename => "#{@paper.nome}")
  end

  def getResumo
    @paper = Paper.find(params[:id])
    send_data(@paper.resumo, :filename => "#{@paper.nome_resumo}")
  end
end
