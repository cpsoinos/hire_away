require_relative "../spec/support/factory_girl.rb"

5.times do
  FactoryGirl.create(:venue)
end

5.times do
  FactoryGirl.create(:event)
end

10.times do
  FactoryGirl.create(:user)
end
