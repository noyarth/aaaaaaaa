

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_cartel', 'Cartel', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_cartel', 'Cartel', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_cartel', 'Cartel', 1)
;

INSERT INTO `factions` (name, label) VALUES
	('cartel', 'Cartel')
;

INSERT INTO `faction_grades` (faction_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('cartel',0,'recrue','Habitant',0,0,0),
	('cartel',1,'novice','Ganster',0,0,0),
	('cartel',2,'experimente','MainDroit',0,0,0),
	('cartel',3,'boss','OG',0,0,0)
;
