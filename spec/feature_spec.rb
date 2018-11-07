require './lib/oystercard'
# In order to use public transport
# As a customer
# I want money on my card
puts '>> oystercard = Oystercard.new'
puts oystercard = Oystercard.new
puts '>> oystercard10 = Oystercard.new(10)'
puts oystercard10 = Oystercard.new(10)
#
# In order to keep using public transport
# As a customer
# I want to add money to my card
puts '>> oystercard.top_up(20)'
puts oystercard.top_up(20)
puts '>> oystercard.balance'
puts oystercard.balance
#
# In order to protect my money
# As a customer
# I don't want to put too much money on my card
puts '>> oystercard.top_up(100)'
# puts oystercard.top_up(100)
puts 'RuntimeError: Sorry the maximum balance is 90, please try topping up a lower amount.'
#
# In order to pay for my journey
# As a customer
# I need my fare deducted from my card
puts '>> oystercard.touch_in(:london_bridge)'
puts oystercard.touch_in(:london_bridge)
puts '>> oystercard.touch_out(:southwark)'
puts oystercard.touch_out(:southwark)
puts '>> oystercard.balance'
puts oystercard.balance
# puts '>> oystercard.deduct(50)'
# puts oystercard.deduct(50)
# puts 'RuntimeError: Your balance is 10, you do not have enough for this transaction.'
#
# In order to get through the barriers
# As a customer
# I need to touch in and out
puts '>> oystercard.touch_in(:london_bridge)'
puts oystercard.touch_in(:london_bridge)
puts '>> oystercard.touch_out(:southwark)'
puts oystercard.touch_out(:southwark)
#
# In order to pay for my journey
# As a customer
# I need to have the minimum amount for a single journey
puts '>> another_oystercard = Oystercard.new'
puts another_oystercard = Oystercard.new
puts '>> another_oystercard.balance'
puts another_oystercard.balance
puts '>> another_oystercard.touch_in(:london_bridge)'
# puts another_oystercard.touch_in
puts 'RuntimeError: Your balance (£0) is insufficient, you need a balance of £1 to travel.'
#
# In order to pay for my journey
# As a customer
# I need to pay for my journey when it's complete
puts '>> oystercard.touch_in(:london_bridge)'
puts oystercard.touch_in(:london_bridge)
puts '>> oystercard.touch_out(:southwark)'
puts oystercard.touch_out(:southwark)
puts '>> oystercard.balance'
puts oystercard.balance
#
# In order to pay for my journey
# As a customer
# I need to know where I've travelled from
puts '>> oystercard.touch_in(:euston)'
puts oystercard.touch_in(:euston)
puts '>> oystercard.entry_station'
puts oystercard.entry_station
#
# In order to know where I have been
# As a customer
# I want to see to all my previous trips
puts '>> oystercard.journey_history'
puts oystercard.journey_history
#
# In order to know how far I have travelled
# As a customer
# I want to know what zone a station is in
#
# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
#
# In order to be charged the correct amount
# As a customer
# I need to have the correct fare calculated
