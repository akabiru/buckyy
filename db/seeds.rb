class Seed
  def create_bucketlists
    Bucketlist.create(
      name: Faker::Lorem.word,
      created_by: Faker::StarWars.character
    )
  end

  def create_items
    Bucketlist.all.each do |bucketlist|
      bucketlist.items.create(name: Faker::StarWars.character)
    end
  end

  def perform
    Bucketlist.destroy_all
    Item.destroy_all
    10.times { create_bucketlists }
    create_items
  end
end

Seed.new().perform
