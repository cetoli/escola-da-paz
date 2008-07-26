class Arquivo < ActiveRecord::Base
  has_many :bibliotecas

  validates_presence_of :nome, :codigo
  validates_uniqueness_of :codigo
  validates_length_of :codigo, :within => 3..5
  validates_length_of :nome, :within => 5..50

  attr_protected :id
end
