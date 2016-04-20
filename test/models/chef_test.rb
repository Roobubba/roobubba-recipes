require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Isaac", email: "isaac@isaac.isaac")
  end

  test "Chef should be valid" do
    assert @chef.valid?
  end

  test "Chefname must be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "Chefname must be >= 3 characters" do
    @chef.chefname = "a"
    assert_not @chef.valid?
  end
  
  test "Chefname must be <= 40 characters" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "Email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "Email length must be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end

  test "Email must be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "Email validation should accept valid email addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@ex.com first.last@www.au l+a@mon.ca]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "Email validation should reject invalid email addresses" do
    invalid_addresses = %w[user@eee,com R_TDD-DS_at_eee.hello.org user@ex. first.last@i_am_.au la@mon+aa.ca]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be valid'
    end
  end

end