class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :escolaridade_id, :int, :null => false
      t.column :curso_id, :int, :null => false
      t.column :periodo, :int, :limit => 1, :null => false
      t.column :cr, :decimal, :precision => 4, :scale => 2, :null => false
      t.column :nome, :string, :limit => 50, :null => false
      t.column :login, :string, :limit => 10, :null => false
      t.column :pass, :string, :limit => 40, :null => false
      t.column :salt, :string, :limit => 10, :null => false
      t.column :email, :string, :limit => 45, :null => false
      t.column :bairro, :string, :limit => 50, :null => false
      t.column :cep, :string, :limit => 10, :null => false
      t.column :telefone, :string, :limit => 13, :null => false
      t.column :celular, :string, :limit => 13, :null => false
      t.column :dre, :string, :limit => 9, :null => false
      t.column :formacao, :string, :limit => 100, :null => false
      t.column :interesse, :string, :limit => 100, :null => false
      t.column :turno, :string, :limit => 100, :null => false
      t.column :instituicao, :string, :limit => 100, :null => false
      t.column :endereco, :string, :null => false
      t.column :admin, :boolean, :default => 0, :null => false
      t.column :aprovado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE users ADD UNIQUE INDEX UsrLogUnqIdx USING BTREE(login)'
    execute 'ALTER TABLE users ADD CONSTRAINT FK_Usr_Esc FOREIGN KEY FK_Usr_Esc (escolaridade_id)
            REFERENCES escolaridades (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
    execute 'ALTER TABLE users ADD CONSTRAINT FK_Usr_Cur FOREIGN KEY FK_Usr_Cur (curso_id)
            REFERENCES cursos (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :users
  end
end
