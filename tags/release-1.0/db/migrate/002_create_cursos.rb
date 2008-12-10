class CreateCursos < ActiveRecord::Migration
  def self.up
    create_table :cursos do |t|
      t.column :codigo, :string, :limit => 5, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE cursos ADD UNIQUE INDEX CurCodUnqIdx USING BTREE(codigo)'

    # Populate with Default Values
    Curso.create :codigo => 'DIR', :nome => 'Direito'
    Curso.create :codigo => 'INF', :nome => 'Informática'
    Curso.create :codigo => 'PED', :nome => 'Pedagogia'
    Curso.create :codigo => 'LET', :nome => 'Letras'
    Curso.create :codigo => 'MED', :nome => 'Medicina'
    Curso.create :codigo => 'CPL', :nome => 'Ciências Políticas'
    Curso.create :codigo => 'OUT', :nome => 'Outro'
  end

  def self.down
    drop_table :cursos
  end
end
