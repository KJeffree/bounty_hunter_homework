require_relative('./models/bounty.rb')

require('pry')

Bounty.delete_all()

bounty1 = Bounty.new(
  'name' => 'Indianna Jones',
  'bounty_value' => 5000,
  'danger_level' => 'low',
  'favourite_weapon' => 'whip'
)

bounty2 = Bounty.new(
  'name' => 'Kissin Kate Barlow',
  'bounty_value' => 20000,
  'danger_level' => 'high',
  'favourite_weapon' => 'gun'
)

bounty3 = Bounty.new(
  'name' => 'Voldemort',
  'bounty_value' => 100000,
  'danger_level' => 'mortal peril',
  'favourite_weapon' => 'elder wand'
)

bounty1.save()
bounty2.save()
bounty3.save()

bounty1.bounty_value = 7000

bounty1.update()

bounty2.delete()

bounties = Bounty.all()

bounty_found = Bounty.find(bounty3.id)

binding.pry
nil
