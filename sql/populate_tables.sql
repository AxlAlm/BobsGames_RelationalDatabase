

INSERT INTO platform_types (name) VALUES
("pc"),
("console"),
("mobile"),
("steamdeck");

INSERT INTO platforms (name, platform_type_id) VALUES
("pc",1),
("xbox", 2),
("playstation", 2),
("steamdeck",4),
("nintendo switch", 2);

INSERT INTO distribution_services (name) VALUES
("steam"),
("playstation"),
("epic games"),
("xbox"),
("nintento");

INSERT INTO vendors (name) VALUES
("steam store"),
("playstation store"),
("xbox store"),
("nintendo store"),
("epic games store"),
("gamestop");

INSERT INTO distribution_services_platform (distribution_service_id, platform_id) VALUES
(1,1),
(1,4),
(2,3),
(3,1),
(4,2),
(5,5);

INSERT INTO games (name) VALUES 
("tides of wrath"), 
("too many zombies!"),
("cabin in the woods"),
("gohanth");


INSERT INTO game_categories (name) VALUES
("strategy"),
("survival"),
("fps"),
("rpg"),
("action"),
("inventory management"),
("puzzle"),
("scenic");


INSERT INTO game_game_categories (game_id, game_category_id) VALUES
(1,1),
(1,6),
(2,2),
(2,5),
(2,3),
(2,4),
(3,6),
(3,7),
(3,8),
(4,4);



INSERT INTO game_vendor (game_id, vendor_id) VALUES
(1,1),
(1,5),
(1,6),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5),
(2,6),
(3,1),
(3,2),
(3,3),
(3,4),
(3,5),
(3,6),
(4,1),
(4,2),
(4,3),
(4,4),
(4,5),
(4,6);


INSERT INTO game_platform (game_id, platform_id) VALUES
(1,1),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5),
(3,2),
(3,3),
(3,5),
(4,2);



