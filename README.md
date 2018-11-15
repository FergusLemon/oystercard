# Oystercard
A program written in Ruby as part of the Makers Academy course (week 2).  The program attempts to implement the 'Oystercard' system used in London to travel on the underground, bus and overground nertworks.

Users can get new oystercards and top them up with money so that they can touch in and touch out of stations and go on journeys.  Each oystercard has a maximum balance and
there are various error messages that will be encountered related to the balance (money available) on the oystercard. A station has a name and a zone.

A valid journey has an entry station and an exit station.  The fare charged for the journey is dependent on the zones of the entry and exit stations.

If a user makes an invalid journey they will be charged a penalty fare.  An invalid journey is one where a touch in or touch out occurs out of sequence (a valid journey should start with a touch in
and end with a touch out).  A full list of journeys will be held on each oystercard in the journeylog.

### Installation

- [ ] **Step 1** - Clone this repository by copying the link available at the top of this webpage in the green button labelled 'Clone or Download'. 
- [ ] **Step 2** - Open up a Terminal window (Mac OS) and run `git clone <link>` where `<link>` is what you copied in the previous step.
```
>> git clone https://github.com/FergusLemon/oystercard.git
```
- [ ] **Step 3** - `cd` into the cloned directory.
- [ ] **Step 4** - Open `irb`, `pry` or any other interactive Ruby interpreter.
- [ ] **Step 5** - `require` the pilot.rb file located in the `lib` directory.  Your interactive Ruby interpreter may have done this for you already depending on its configuration settings, if so jump to Step 6. 
- [ ] **Step 6** - You can now instantiate objects of classes Oystercard, Station, Journey and JourneyLog and send them messages to invoke behaviour. The file `feature_spec.rb` lists user stories and exhibits much of the program's functionality.
To see this run `ruby spec/feature_spec.rb` from the command line when the working directory is the `oystercard` directory.

### Code Examples
In these code examples `>>` represents the command line prompt.  Lines without the prompt show the return value of the preceeding expression.

Create a new oystercard with a zero balance and another new oystercard with a balance of £50.
```
>> oystercard = Oystercard.new
#<Oystercard:0x00007fc1e4056858 @balance=0, @journey_log=#<JourneyLog:0x00007fc1e4056830 @journeys=[], @journey_klass=Journey>>
>> another_oystercard = Oystercard.new(50)
#<Oystercard:0x00007fc1e405b358 @balance=50, @journey_log=#<JourneyLog:0x00007fc1e405b330 @journeys=[], @journey_klass=Journey>>

```
Create some stations.
```
>> euston = Station.new(:euston, 1)
#<Struct:Station:0x7fc1e28e4008
    name = :euston,
    zone = 1
>
>> angel = Station.new(:angel, 2)
#<Struct:Station:0x7fc1e405ec38
    name = :angel,
    zone = 2
>
>> tooting = Station.new(:tooting, 4)
#<Struct:Station:0x7fc1e31a5660
    name = :tooting,
    zone = 4
>
```
Attempt to touch in at a station with a card when its balance is below the minumum fare.
```
>> oystercard.touch_in(euston)
RuntimeError (Your balance (£0) is insufficient, you need a balance of £1 to travel.)
```
Touch in with a card that has a sufficient balance.
```
>> another_oystercard.touch_in(euston)
#<Oystercard:0x00007fc1e405b358 @balance=50, @journey_log=#<JourneyLog:0x00007fc1e405b330 @journeys=[#<Journey:0x00007fc1e38375a0 @entry_station=#<struct Station name=:euston, zone=1>, @complete=false>], @journey_klass=Journey>>
```
Touch out and the balance on the card will be reduced by the appropriate fare and the complete journey will be stored in the journey log.
```
>> another_oystercard.touch_out(angel)
48
```
Top up the card with a low balance.
```
>> oystercard.top_up(25)
25
```
But it cannot have a balance larger than its limit.
```
>> oystercard.top_up(100)
RuntimeError (Sorry the maximum balance is 90, please try topping up a lower amount.)
```
Touch in and then touch in again without touching out and a penalty fare will be deducted from the card's balance.
```
>> oystercard.touch_in(angel)
#<Oystercard:0x00007fc1e4056858 @balance=25, @journey_log=#<JourneyLog:0x00007fc1e4056830 @journeys=[#<Journey:0x00007fc1e2951680 @entry_station=#<struct Station name=:angel, zone=2>, @complete=false>], @journey_klass=Journey>>
>> oystercard.touch_in(tooting)

>> oystercard.touch_in(tooting)
#<Oystercard:0x00007fc1e4056858 @balance=19, @journey_log=#<JourneyLog:0x00007fc1e4056830 @journeys=[#<Journey:0x00007fc1e2951680 @entry_station=#<struct Station name=:angel, zone=2>, @complete=true, @exit_station=nil>, #<Journey:0x00007fc1e28b54d8 @entry_station=#<struct Station name=:tooting, zone=4>, @complete=false>], @journey_klass=Journey>>
```
You can touch out once on a zero balance oystercard but after that you will be prompted to top up your card's balance to get it back to at least the amount of the minimum fare.  You can also see that the initial touch out on a zero balance was recorded as a journey in the journey log and it incurred a penalty fare as the entry station is marked as `nil`.
```
>> one_more_oystercard = Oystercard.new
#<Oystercard:0x00007fab122765b8 @balance=0, @journey_log=#<JourneyLog:0x00007fab12276590 @journeys=[], @journey_klass=Journey>>
>> one_more_oystercard.touch_out(tooting)
-6
>> one_more_oystercard
#<Oystercard:0x00007fab122765b8 @balance=-6, @journey_log=#<JourneyLog:0x00007fab12276590 @journeys=[#<Journey:0x00007fab122132b0 @entry_station=nil, @complete=true, @exit_station=#<struct Station name=:tooting, zone=4>>], @journey_klass=Journey>>
>> one_more_oystercard.touch_out(tooting)
RuntimeError: Your have a negative balance of (£-6) please top up at least £7 before making your journey.
```
### Test
Unit tests can be located in the `spec` directory and can be run from the `oystercard` directory using the command `rake`.  There is also a feature spec file that contains user stories and code examples as mentioned in step 6 of the installation guide above.

### License
MIT (c) 2018 Fergus Lemon

See `LICENSE` for more detail.
