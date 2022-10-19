CREATE DATABASE trains;
USE trains;

CREATE TABLE passenger (
	id INT IDENTITY(1,1),
	CF NVARCHAR(18),
	name NVARCHAR(30) NOT NULL, 
	surname NVARCHAR(30) NOT NULL,
	birth_data DATE NOT NULL,
	CONSTRAINT pk_id_cf PRIMARY KEY (id, CF),
);

CREATE TABLE station (
	id INT IDENTITY(1,1) PRIMARY KEY,
	station_abbrevation NVARCHAR(10) NOT NULL,
	address NVARCHAR(30) NOT NULL,
);

CREATE TABLE railway_line (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_departure_station INT FOREIGN KEY REFERENCES station(id), 
	id_arrival_station INT FOREIGN KEY REFERENCES station(id),
);

CREATE TABLE travel (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_railway_line INT FOREIGN KEY REFERENCES railway_line(id),
	departure_data DATETIME NOT NULL,
	duration TIME NOT NULL,
	delay TIME,
);

CREATE TABLE ticket (
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_passenger INT FOREIGN KEY REFERENCES passenger(id),
	id_travel INT FOREIGN KEY REFERENCES travel(id)
)
