-- CREATING ALL TABLES

-- in this table we store names of platforms types. E.g. PC, console, mobile
CREATE TABLE platform_types (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

-- in this table we store names of platforms. E.g. PC, PlayStation, Xbox, IOS etc, and which platform type they have.
-- platforms are in a many-to-one relationship to platform_types as a many platforms can have the same type. e.g. Xbox
-- and Playstation are box console platform types. Hence, we dont need an additional table to store this relationship, but can
-- store it using a FOREIGN KEY
CREATE TABLE platforms (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    platform_type_id INT NOT NULL,
    FOREIGN KEY (platform_type_id) REFERENCES platform_types(id),
    UNIQUE(name)
);

-- in this table we store names of vendors. E.g. steam, gamestop
CREATE TABLE vendors (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

-- in this table we store information about existing distribution service, e.g. Steam, PlayStation, Xbox, Apple
-- NOTE! we dont include platform in this table as distribution_services and platform can be in a many-to-many relationship
-- for example, Steam is available both on PC and on the SteamDeck
CREATE TABLE distribution_services (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

-- In this table we store information about what distribution services is available on which platform.
-- Relationship between distribution services and platforms are many-to-many as many distribution services
-- can be only many playforms and platforms can have many distributions services.
-- For example, PlayStation is available on PlayStation, Steam is available on PC and SteamDeck, and Epic games and Steam
-- are both available on PC.
CREATE TABLE distribution_services_platform (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    distribution_service_id INT NOT NULL,
	platform_id INT NOT NULL,
	FOREIGN KEY (distribution_service_id) REFERENCES distribution_services(id),
	FOREIGN KEY (platform_id) REFERENCES platforms(id)
);


-- in this table we store names of the different categories. E.g. RPG, Strategy, FPS
CREATE TABLE game_categories (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

-- in this table we store names of games. E.g. Skyrim
CREATE TABLE games (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

-- in this table we store information about what categories games are. This is because game to game category is a many-to-many relationship
-- as games can have many categories and categories can "have" multiple games.
CREATE TABLE game_game_categories (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    game_category_id INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (game_category_id) REFERENCES game_categories(id)
);

-- in this table we store information about what games is available on what vendor
-- many-to-many relationship as many games can be on many vendors and many vendors can have many games
CREATE TABLE game_vendor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    vendor_id INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (vendor_id) REFERENCES vendors(id)
);

-- in this take we store information about what game is available on what platform
-- many-to-many relationship as games can be on many platforms and platforms can have many games
--
-- NOTE! its not appropriate to relate game to distribution_services as game can be bought outside of a distribution_services
-- We could get information about vendor  ....
CREATE TABLE game_platform (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    platform_id INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id)
);

-- in this take we store information about what game is available on what distribution_services
-- many-to-many relationship as games can be on many distribution_services and distribution_services can have many games
CREATE TABLE game_distribution_services (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    distribution_services_id INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (distribution_services_id) REFERENCES distribution_services(id)
);

-- in this table we store information about users
-- these will be unique users accross multiple distribution platforms
-- for example, if we have a steam user and a playstation user with the same
-- name, birthdate and address (etc), we can assume that they are the same individual
CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL,
    country VARCHAR(255) NOT NULL, 
    city VARCHAR(255) NOT NULL,
    postal_code INT NOT NULL,
    street_address VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    CONSTRAINT name_address_birthdate UNIQUE(first_name,last_name, birthdate, postal_code, street_address)
);

-- this table contains information about accounts on distribution services. These accounts are unique per distribution service
-- but these accounts are in many-to-one relationship with users; multiple distribution service accounts can have the same
-- user. For example, I can have accounts on Steam and on PlayStation but I will still be the same general user.
CREATE TABLE IF NOT EXISTS distribution_service_accounts (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    distribution_service_id INT NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (distribution_service_id) REFERENCES distribution_services(id),
    CONSTRAINT unique_dp_acc UNIQUE(user_name, distribution_service_id)
);

-- all keys for all individual copies of each game for each platform
--  Here we have a one-to-many relationship as games and platforms can have multiple keys but each key can only
-- be related to one game and platform
CREATE TABLE game_keys(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	game_id INT NOT NULL,
    platform_id INT NOT NULL,
	game_key VARCHAR(255) NOT NULL,
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (platform_id) REFERENCES platforms(id),
    CONSTRAINT unique_key UNIQUE(game_key)
);

-- all purchases. These might include bulk purchases from vendors such as GameStop or 
CREATE TABLE purchases (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	game_id INT NOT NULL,
	vendor_id INT NOT NULL,
	quantity INT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (vendor_id) REFERENCES vendors(id)
);

CREATE TABLE game_key_purchase (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	game_key_id INT NOT NULL,
	purchase_id INT NOT NULL,
	FOREIGN KEY (game_key_id) REFERENCES game_keys(id),
	FOREIGN KEY (purchase_id) REFERENCES purchases(id)
);


CREATE TABLE user_game_key (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT NOT NULL,
	game_key_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (game_key_id) REFERENCES game_keys(id)
);

