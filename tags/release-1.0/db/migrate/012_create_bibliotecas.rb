class CreateBibliotecas < ActiveRecord::Migration
  def self.up
    create_table :bibliotecas do |t|
      t.column :arquivo_id, :int, :null => false
      t.column :titulo, :string, :null => false
      t.column :nome, :string, :null => false
      t.column :anexo, :binary, :limit => 5.megabytes
    end

    execute 'ALTER TABLE bibliotecas ADD UNIQUE INDEX BibTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE bibliotecas ADD UNIQUE INDEX BibNomUnqIdx USING BTREE(nome)'
    execute 'ALTER TABLE bibliotecas ADD CONSTRAINT FK_Bib_Arq FOREIGN KEY FK_Bib_Arq (arquivo_id)
            REFERENCES arquivos (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :bibliotecas
  end
end
