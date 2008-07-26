class CreateEscolaridades < ActiveRecord::Migration
  def self.up
    create_table :escolaridades do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE escolaridades ADD UNIQUE INDEX EscCodUnqIdx USING BTREE(codigo)'
    execute 'ALTER TABLE escolaridades ADD UNIQUE INDEX EscNomUnqIdx USING BTREE(nome)'

    # Populate with Default Values
    Escolaridade.create :codigo => 'GRAD', :nome => 'Graduação'
    Escolaridade.create :codigo => 'MEST', :nome => 'Mestrado'
    Escolaridade.create :codigo => 'DOUT', :nome => 'Doutorado'
    Escolaridade.create :codigo => 'ESPC', :nome => 'Especialização'
  end

  def self.down
    drop_table :escolaridades
  end
end
