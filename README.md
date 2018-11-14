# Oystercard
A program written in Ruby as part of the Makers Academy course (week 2).  The program attempts to implement the 'Oystercard' system used in London to travel on the underground, bus and overground nertworks.

Users can get new oystercards and top them up with money so that they can touch in and touch out of stations and go on journeys.  Each oystercard has a maximum balance and
there are various error messages that will be encountered related to the balance (money available) on the oystercard. A station has a name and a zone.

A valid journey has an entry station and an exit station.  The fare charged for the journey is dependent on the zones of the entry and exit stations.

If a user makes an invalid journey they will be charged a penalty fare.  An invalid journey is one where a touch in or touch out occurs out of sequence (a valid journey should start with a touch in
and end with a touch out).  
A full list of journeys will be held on each oystercard in the journeylog.

### Installation

- [ ] Step 1 - Clone this repository by copying the link available at the top of this webpage in the green button labelled 'Clone or Download'. 
- [ ] Step 2 - Open up a Terminal window (Mac OS) and run `git clone <link>` where `<link>` is what you copied in the previous step.
- [ ] Step 3 - `cd` into the cloned directory.
- [ ] Step 4 - Open `irb`, `pry` or any other interactive Ruby interpreter.
- [ ] Step 5 - `require` the pilot.rb file located in the `lib` directory.  Your interactive Ruby interpreter may have done this for you already depending on its configuration settings, if so jump to Step 6. 
- [ ] Step 6 - You can now instantiate objects of classes Oystercard, Station, Journey and JourneyLog and send them messages to invoke behaviour. The file `feature_spec.rb` lists user stories and exhibits much of the program's functionality.
To see this run `ruby spec/feature_spec.rb` from the command line when the working directory is the `oystercard` directory.

### Code Examples
In these code examples `>>` represents the command line prompt.  Lines without the prompt show the return value of the preceeding expression.
