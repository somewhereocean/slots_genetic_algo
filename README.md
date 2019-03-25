# SlotEvolution


## Installation

    $ bundle install

## Usage

To play a slot machine from a console, run 

    $ bin/spin -p <path_to_the_config> -f <config_name> -b <your_bet> -s <your_start_balance>

So it will be something like this :

    $ bin/spin -p 'spec/fixtures/' -f 'game_config' -b 10 -s 100

Check out spec/fixtures folder for valid game configs.

To run genetic algorithm use this :

    $ bin/evolution -p <path_to_the_config> -f <config_name> -b <your_bet> -r <goal_rtp> -e <population_size> -n <number_of_parents> -g <max_number_of_generations> -s <number_of_simulations> -i <import_folder>

The example below will find an individual ( reel strips ) with RTP 95% or the closest to that value ( if max depth is reached ), where each population size is 10 individuals and 3 of them are chosen as parents from a current population to generate a new generation. Result will be stored to strips folder ( please create it before ). Your bet per spin is 10 coins. There will be 200_000 simulations to calculate RTP for each individual in a population.

    $ bin/evolution -p 'spec/fixtures/' -f 'game_config' -b 10 -r 0.95 -e 10 -n 3 -g 15 -s 200_000 -i strips

Cheers!

## Specs

To run specs 

    $ rspec spec

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
