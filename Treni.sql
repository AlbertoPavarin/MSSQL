CREATE DATABASE trains;
USE trains;

CREATE TABLE passenger (
	id INT IDENTITY(1,1) PRIMARY KEY,
	CF NVARCHAR(18) UNIQUE,
	name NVARCHAR(30) NOT NULL, 
	surname NVARCHAR(30) NOT NULL,
	birth_data DATE NOT NULL,
);

CREATE TABLE station (
	id INT IDENTITY(1,1) PRIMARY KEY,
	station_abbrevation NVARCHAR(10) NOT NULL,
	address NVARCHAR(30) NOT NULL,
	city NVARCHAR(25) NOT NULL,
);

CREATE TABLE railway_line (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_departure_station INT FOREIGN KEY REFERENCES station(id), 
	id_arrival_station INT FOREIGN KEY REFERENCES station(id),
	CONSTRAINT un_railway_line UNIQUE (id, id_departure_station, id_arrival_station)
);

CREATE TABLE travel (
	id INT IDENTITY(1,1),
	id_railway_line INT FOREIGN KEY REFERENCES railway_line(id),
	departure_data DATETIME NOT NULL,
	duration TIME NOT NULL,
	delay TIME, 
);

ALTER TABLE travel 
ADD CONSTRAINT pk_travel PRIMARY KEY (id);

CREATE TABLE ticket (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_passenger INT FOREIGN KEY REFERENCES passenger(id),
	id_travel INT FOREIGN KEY REFERENCES travel(id),
	price DECIMAL,
);

SELECT p.name AS 'Nome', p.surname AS 'Cognome', p.CF AS 'Codice Fiscale', s.station_abbrevation AS 'abbreviazione stazione di partenza', s.city AS 'Città di partenza', s.address AS 'Indirizzo stazione di partenza',
s2.station_abbrevation AS 'abbreviazione stazione di arrivo', s2.city AS 'Città di arrivo', s2.address AS 'Indirizzo stazione di arrivo', ti.price AS 'Prezzo'
FROM ticket ti 
LEFT JOIN travel tr ON ti.id_travel  = tr.id  
LEFT JOIN railway_line rl ON tr.id_railway_line = rl.id 
LEFT JOIN station s ON rl.id_departure_station = s.id 
LEFT JOIN station s2 ON rl.id_arrival_station = s2.id
LEFT JOIN passenger p ON p.id = ti.id_passenger 
WHERE 1 = 1;