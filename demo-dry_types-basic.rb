require 'dry-types'

module Types
  include Dry::Types.module
end

class Student < Dry::Types::Struct
  attribute :name, Types::String
  attribute :id, Types::Int
end

class Etudiant < Dry::Types::Value
  attribute :name, Types::String
  attribute :id, Types::Int
end

stu = Student.new(name: 'Piotr Solnic', id: 3429788)
etu = Etudiant.new(name: 'Peter Solnic', id: 3429788)
