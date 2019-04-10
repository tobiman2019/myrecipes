require "test_helper"

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Chinedum", email: "gud4tob@yahoo.com")
  end 
  
  test "chef must be valid" do
    assert @chef.valid?
  end
  
  test "chef name must be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test "email must be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test "chef name must be less than 30" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  
  test "email should not be too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email must accept correct format" do
    valid_emails = %w[chinedum.tobias@yahoo.com GLORYNNAJI@gmail.com JohN_emeka@hotmail.com EBUD@yahoo.co.uk]
    valid_emails.each do |vldemail|
      @chef.email = vldemail 
      assert @chef.valid?, "#{vldemail.inspect} should be valid"
    end
  end
  
  test "email must reject invalid emails" do
    invalid_emails = %w[chinemdum@yahoo glory@gmail. john@yahoo,com emy@aemu+yahoo.com]
    invalid_emails.each do |invldemail|
      @chef.email = invldemail
      assert_not @chef.valid?, "#{invldemail.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case-insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "email should be lowercase before hitting db" do
    mixed_email = "EMeKaG@yahoo.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
  
end