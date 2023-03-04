

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mafia', 'mafia', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_mafia', 'mafia', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mafia', 'mafia', 1)
;

INSERT INTO `factions` (name, label) VALUES
	('mafia', 'mafia')
;

INSERT INTO `faction_grades` (faction_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mafia',0,'recrue','Habitant',0,0,0),
	('mafia',1,'novice','Ganster',0,0,0),
	('mafia',2,'experimente','MainDroit',0,0,0),
	('mafia',3,'boss','OG',0,0,0)
;
