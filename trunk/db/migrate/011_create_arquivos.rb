class CreateArquivos < ActiveRecord::Migration
  def self.up
    create_table :arquivos do |t|
      t.column :codigo, :string, :limit => 5, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE arquivos ADD UNIQUE INDEX ArqCodUnqIdx USING BTREE(codigo)'

    # Populate with Default Values
    Arquivo.create :codigo => 'LIVRO', :nome => 'Livro'
    Arquivo.create :codigo => 'TESE', :nome => 'Tese'
    Arquivo.create :codigo => 'DISSE', :nome => 'Dissertação'
    Arquivo.create :codigo => 'MONOG', :nome => 'Monografia'
    Arquivo.create :codigo => 'ARTIG', :nome => 'Artigo'
    Arquivo.create :codigo => 'TEXTO', :nome => 'Texto'
    Arquivo.create :codigo => 'APRES', :nome => 'Apresentação'
  end

  def self.down
    drop_table :arquivos
  end
end
