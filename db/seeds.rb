class Seed

  def create_user
    @user = User.create(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      email: "me@andela.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  def create_bucketlists
    @user.bucketlists.create(
      name: Faker::Lorem.word
    )
  end

  def create_items
    Bucketlist.all.each do |bucketlist|
      bucketlist.items.create(name: Faker::StarWars.character)
    end
  end

  def perform
    Token.destroy_all
    User.destroy_all
    Bucketlist.destroy_all
    Item.destroy_all
    create_user
    200.times { create_bucketlists }
    create_items
  end
end

Seed.new().perform
