# Example database for a Game Developer called BobsGames

This repo contains an example of how a relational database database with the propose of **insights and analytics** can look for a game developer.

Here are the following settings / assumptions for this example:

- BobsGames only business is to make and sell games
- all games are essentially Game keys
- BobsGames do not sell games themselves by rely on 3rd parties such as Steam, PlayStation Store and GameStop and so on, to sell their games. We will refer to these as **vendors**
- BobsGames's games are played via 3rd party distribution services such as Steam, PlayStation, Epic Games, Apple (iOS) and so on. We will refer to these as **distribution services**
- the company can get information from the **distribution services**. This information is the following (this might be very far form reality!):
  - name and address of user that own BobsGames's games
  - information when user play BobsGames's games

## Lets first take a look at how users/customers get their games!

#### scenario 1: Buy via online vendors which is also a distribution service

Lets say someone buys a game at Steam. Steam will take care of the order and payment, then request a game key from BobsGames. This will be registered as a new purchase in BobsGames. We will also get additional information about the purchaser, e.g. which account bought the game and additional information such as name adress etc.

#### scenario 2: Buys a key online then enable it on a distribution service

Lets say someone buys a game online at GameStop and then use the key in PlayStation.

For GameStop to be able to sell BobsGames's games they have to have bought a games from BobsGames in bulk. So what the customer buys is key BobsGames have sold to GameStop. Hence, BobsGames has already a purchase registered for all those keys to GameStop, and does not get any additional information when they key is sold by GameStop to the customer. However, when the game key is activated in PlayStation, we get information we get information

(NOTE! if someone buys a physical copy of the game this would be the same scenario)

## Lets take a look at some questions that we might be interested in getting answers for!

- How many people play our games?
- what's the most popular game?
- what's the most popular platform?
- what's the most popular game category?
- what's the most popular vendor?
- What's the average number of games owned by all game owners?
- Do poeple BobsGames's games accross platforms? (Do they own games on both PC and console?)

## Some thoughts

- should steam be counted as vendors or just a distribution services. Can we categorize Steam and GameStop togethere in some category and then add granular tpyes to differentiate them? Would this be better?

## TODO

- add some tables for storing real time information from distribution services
