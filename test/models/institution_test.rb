require 'test_helper'

class InstitutionTest < ActiveSupport::TestCase
  should have_many(:jobs).dependent(:destroy)
  should have_many(:permissions).dependent(:destroy)
  should have_many(:users).through(:permissions)
  
  should validate_presence_of :name
  should validate_presence_of :description
  should validate_presence_of :category

  should define_enum_for(:category).with([:agriculture, :construction, :transportation, :communications,
                                          :sanitary, :services, :healthcare])

  test "should include EnumAddons" do
    message ||= "It's not implementing concern EnumAddons"
    inherit_it = Institution.included_modules.include?(EnumAddons)
    assert inherit_it, message
  end

end
