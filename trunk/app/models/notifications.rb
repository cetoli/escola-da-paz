class Notifications < ActionMailer::Base

  @@remetente = 'adm.escola.paz@ufrj.br'
  @@caracteres = 'ISO-8859-1'

  def userApproval(to, nome, email, sent_at = Time.now)
    @subject    = '[Escola da Paz] - Aprovação de Usuário'
    @body       = {:nome => nome, :email => email}
    @recipients = to
    @from       = @@remetente
    @sent_on    = sent_at
    @headers    = {}
    @charset    = @@caracteres
  end

  def docApproval(to, title, creation, modification, author, sent_at = Time.now)
    @subject    = '[Escola da Paz] - Aprovação de Documento'
    @body       = {:title => title, :creation => creation, :modification => modification, :author => author}
    @recipients = to
    @from       = @@remetente
    @sent_on    = sent_at
    @headers    = {}
    @charset    = @@caracteres
  end

  def prjApproval(to, title, creation, modification, author, sent_at = Time.now)
    @subject    = '[Escola da Paz] - Aprovação de Projeto'
    @body       = {:title => title, :creation => creation, :modification => modification, :author => author}
    @recipients = to
    @from       = @@remetente
    @sent_on    = sent_at
    @headers    = {}
    @charset    = @@caracteres
  end

  def semApproval(to, title, creation, author, sent_at = Time.now)
    @subject    = '[Escola da Paz] - Aprovação de Seminário'
    @body       = {:title => title, :creation => creation, :author => author}
    @recipients = to
    @from       = @@remetente
    @sent_on    = sent_at
    @headers    = {}
    @charset    = @@caracteres
  end

  def userAcceptance(to, nome, login, sent_at = Time.now)
    @subject    = '[Escola da Paz] - Bem Vindo à Plataforma Escola da Paz'
    @body       = {:nome => nome, :login => login}
    @recipients = to
    @from       = @@remetente
    @sent_on    = sent_at
    @headers    = {}
    @charset    = @@caracteres
  end
  
  def forgot_password(to, nome, login, pass, sent_at = Time.now)
    @subject    = "[Escola da Paz] - Sua senha é..."
    @body       = {:nome => nome, :login => login, :pass => pass}
    @recipients = to
    @from       = @@remetente
    @sent_on    = sent_at
    @headers    = {}
    @charset    = @@caracteres
  end
end
