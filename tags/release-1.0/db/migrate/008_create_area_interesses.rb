class CreateAreaInteresses < ActiveRecord::Migration
  def self.up
    create_table :area_interesses_users, :id => false do |t|
      t.column :area_interess_id, :integer
      t.column :user_id, :integer
    end

    create_table :area_interesses do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE area_interesses ADD UNIQUE INDEX AitCodUnqIdx USING BTREE(codigo)'
    execute 'ALTER TABLE area_interesses ADD UNIQUE INDEX AitNomUnqIdx USING BTREE(nome)'

    # Populate with Default Values
    AreaInteress.create :codigo => 'DIRIN', :nome => 'Direito Internacional'
    AreaInteress.create :codigo => 'POLIN', :nome => 'Política Internacional'
    AreaInteress.create :codigo => 'DIRHM', :nome => 'Direitos Humanos'
    AreaInteress.create :codigo => 'OUTRA', :nome => 'Outra'
  end

  def self.down
    drop_table :area_interesses_users
    drop_table :area_interesses
  end
end
