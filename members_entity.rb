require 'dry-types'
require 'dry-struct'

module Entity
  # Add dry types to Entity module
  module Types
    include Dry::Types.module
  end
end

module Entity
  # Domain entity for team members
  class Member < Dry::Struct
    include Dry::Types.module

    attribute :id,        Integer.optional
    attribute :origin_id, Strict::Integer
    attribute :username,  Strict::String
    attribute :email,     Strict::String.optional

    def git_identity
      "(#{origin_id}) #{username}"
    end
  end
end

ray = Entity::Member.new(
  id:nil, origin_id: 3248987,
  username: 'soumyaray', email: nil
)
# => #<Entity::Member id=nil origin_id=12 username="soumyaray" email=nil>

# Assume request was previously sent to an external service
# Response now comes in from an external service
service_response = {
  id:nil, origin_id: 2349493,
  username: 'rayray', email: 'soumya.ray@gmail.com'
}

member = Entity::Member.new(service_response)
# => #<Entity::Member id=nil origin_id=2349493 username="rayray" email="soumya.ray@gmail.com">

member.git_identity
# "(2349493) rayray"

ray.email = 'new_email@gmail.com'
# NoMethodError: undefined method `email=' for #<Entity::Member>
