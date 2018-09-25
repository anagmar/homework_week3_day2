require_relative('./models/bounty.rb')
require('pry')

Bounty.delete_all()

space_cowboy1 = Bounty.new({
  'name' => 'Boba Fett',
  'species' => 'Jedi',
  'bounty_value' => 10,
  'danger_level' => 'high'
  })

space_cowboy2 = Bounty.new({
  'name' => 'Jango Fett',
  'species' => 'Clones',
  'bounty_value' => 5,
  'danger_level' => 'med'
  })

space_cowboy1.save()
space_cowboy2.save()

space_cowboys = Bounty.all()
Bounty.update()


binding.pry
nil
