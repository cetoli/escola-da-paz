class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.column :codigo, :string, :limit => 5, :null => false
      t.column :nome, :string, :limit => 50, :null => false
      t.column :artigo, :boolean, :default => 0, :null => false
      t.column :paper, :boolean, :default => 0, :null => false
      t.column :projeto, :boolean, :default => 0, :null => false
      t.column :seminario, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE areas ADD UNIQUE INDEX AreCodUnqIdx USING BTREE(codigo)'

    # Populate with Default Values
    Area.create :codigo => 'DIRIN', :nome => 'Direito Internacional'
    Area.create :codigo => 'POLIN', :nome => 'Política Internacional'
    Area.create :codigo => 'DIRHM', :nome => 'Direitos Humanos'
  end

  def self.down
    drop_table :areas
  end
end
