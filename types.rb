# Example of how to use dry-types to consume/coerce input
# from an external service
# - validation not an issue; external service assumed to be correct
# - coercion might be needed if external service uses different primitives
require 'dry-types'

module Types
  include Dry::Types.module
end

class Student < Dry::Types::Struct
  attribute :id, Types::Strict::Int
  attribute :name, Types::String
  attribute :age, Types::Maybe::Strict::Int
end

# Assume request was previously sent to an external service
# Response now comes in from an external service
service_response = { id: 124, name: 'Joe Shmo', age: nil }

@student = Student.new(service_response)

# @student can be persisted, shown by a view, etc.
