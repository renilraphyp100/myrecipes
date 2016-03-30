require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    
    def setup
        @chef = Chef.new(chefname: "John", email: "john@example.com")
    end
    
    test "Chef should be valid" do
        assert @chef.valid?
    end
    
    test "chefname should be present" do
        @chef.chefname = " "
        assert_not @chef.valid?
    end
    
    test "chefname should not be too long" do
        @chef.chefname = "a" * 41
        assert_not @chef.valid?
    end
    
    test "chefname should not be too short" do
        @chef.chefname = "aa"
        assert_not @chef.valid?
    end
    
    test "email should be present" do
        @chef.email = " "
        assert_not @chef.valid?
    end
    
    test "email should not be within bounds" do
        @chef.email = "a" * 101 + "@example.com"
        assert_not @chef.valid?
    end
    
    test "email should be unique" do
        dup_chef = @chef.dup
        dup_chef.email = @chef.email.upcase
        @chef.save
        assert_not dup_chef.valid?
    end
    
    test "email validation should accept valid emails" do
        valid_addresses = %w[user@eee.com R_Td@eee.hello.org user@example.com first.last@sdjsh.dsds dgshdg+dfhghdfg@dgfhdgf.fsfs]
        valid_addresses.each do |va|
            @chef.email = va
            assert @chef.valid?, "#{va.inspect} should be valid"
        end
    end
    
    test "email validation should reject invalid emails" do
        invalid_addresses = %w[user@example,com user_dhsgd.org user@dfgdhf. jshfjfjs@dfhd_ssdg.com fdhgfhd@fdhf+dfdgf.sdhsd]
        invalid_addresses.each do |ia|
            @chef.email = ia
            assert_not @chef.valid?, "#{ia.inspect} should be invalid"
        end
    end
    
end