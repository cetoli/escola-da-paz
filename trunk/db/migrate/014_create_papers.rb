class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.column :area_id, :int, :null => false
      t.column :user_id, :int, :null => false
      t.column :titulo, :string, :null => false
      t.column :resenha, :text, :null => false
      t.column :nome_resumo, :string
      t.column :resumo, :binary, :limit => 5.megabytes
      t.column :nome, :string
      t.column :anexo, :binary, :limit => 5.megabytes
      t.column :criado, :datetime, :null => false
      t.column :alterado, :datetime, :null => false
      t.column :aprovado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE papers ADD UNIQUE INDEX PapTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE papers ADD CONSTRAINT FK_Pap_Are FOREIGN KEY FK_Pap_Are (area_id)
            REFERENCES areas (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
    execute 'ALTER TABLE papers ADD CONSTRAINT FK_Pap_Usr FOREIGN KEY FK_Pap_Usr (user_id)
            REFERENCES users (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :papers
  end
end
