drop database d15johol;
create database d15johol;
use d15johol;

# Skapa tabeller
create table domare(
	pnr char(11),
	lon int,
	namn varchar(20),
	primary key(pnr)
)engine=innodb;

create table tavling(
	namn varchar(20),
	datum date,
	primary key(namn)
)engine=innodb;
	
create table ansvara(
	pnr char(11),
	namn varchar(20),
	primary key(pnr, namn),
	foreign key(namn) references tavling(namn),
	foreign key(pnr) references domare(pnr)
)engine=innodb;

create table spelare(
	pnr char(11),
	namn varchar(20),
	primary key(pnr)
)engine=innodb;

create table boll(
	signatur varchar(20),
	nr char(11),
	marke varchar(20),
	pnr char(11),
	primary key(signatur),
	foreign key(pnr) references spelare(pnr)
)engine=innodb;

create table speltillfälle(
	starttid datetime,
	resultat int,
	namn varchar(20),
	pnr char(11),
	primary key(starttid, namn, pnr),
	foreign key(namn) references tavling(namn),
	foreign key(pnr) references spelare(pnr)
)engine=innodb;

create table golfbag(
	typ varchar(20),
	marke varchar(20),
	pnr char(11),
	primary key(marke, pnr),
	foreign key(pnr) references spelare(pnr)
)engine=innodb;

create table klubba(
	namn varchar(20),
	kommentar varchar(30),
	pnr char(11),
	marke varchar(20),
	primary key(namn, pnr, marke),
	foreign key(pnr) references spelare(pnr),
	foreign key(marke) references golfbag(marke)
)engine=innodb;

create table caddy(
	pnr char(11),
	favTips varchar(50),
	namn varchar(20),
	spelPnr char(11),
	bagMarke varchar(20),
	primary	key(pnr),
	foreign key(spelPnr) references spelare(pnr),
	foreign key(bagMarke) references golfbag(marke)
)engine=innodb;

# Transaktioner
# Tävling
insert into tavling values
	('Sigges sommargolf','2016-07-10'),
	('Ryder Cup','2014-06-20'),
	('Masters','2077-07-12');

# Domare
insert into domare values
	('790129-4444',12000,'Simon'),
	('810912-5555',12000,'Sven'),
	('790612-1212',12000,'Eva'),
	('850906-3597',12000,'Jens'),
	('770202-3333',12000,'Göran'),
	('780203-7785',55000,'Knugen'),
	('910203-2185',4300,'Gullis');

# Relation mellan Domare och Tävlingar
insert into ansvara values
	('790129-4444','Sigges sommargolf'),
	('810912-5555','Sigges sommargolf'),
	('790612-1212','Sigges sommargolf'),
	('850906-3597','Ryder Cup'),
	('850906-3597','Sigges sommargolf');

# Spelare
insert into spelare values
	('940101-8651','Stina'),
	('670808-2222','Sune'),
	('790101-4343','Benny'),
	('560123-6666','Bosse'),
	('730909-1111','Reidar'),
	('730909-7777','Reidar'),
	('660808-5555','Kurt-Evert');

# Golfbag
insert into golfbag values
	('Super','Boom','940101-8651'),
	('Gogo','SuperbrAND','670808-2222'),
	('Tour','Nike','730909-1111'),
	('Wooow','Titleist','560123-6666'),
	('AndroidBag','Google','660808-5555');

# Klubba
insert into klubba values
	('Dudle','Säkra bettan','940101-8651','Boom'),
	('Driver','Längst och snedast på touren','940101-8651','Boom'),
	('Driver','Spikrak och kort','730909-1111','Nike'),
	('Jensens','Google suger','730909-1111','Nike');

# Caddy
insert into caddy values
	('891010-5468','Knyt skorna hårdare','Anna','670808-2222','SuperbrAND'),
	('461224-4385','Svinga lugnt','Petra','940101-8651','Boom'),
	('551221-9988','Sluta stirra på brudarnas rövar','Jesus','660808-5555','Google'),
	('991221-1235','Sluta stirra','Jeppe','560123-6666','Titleist');	

# Boll
insert into boll values
	('Hjärta',null,'Titleist','670808-2222'),
	('Tre prickar',null,'Titleist','790101-4343'),
	('Superball',null,'Nike','940101-8651'),
	('RANDig',null,'Kina','560123-6666');

# Speltillfälle
insert into speltillfälle values
	('2016-10-07 13:10:00',72,'Sigges sommargolf','670808-2222'),
	('2016-10-07 10:25:00',0,'Sigges sommargolf','560123-6666'),
	('2016-10-07 14:10:00',0,'Sigges sommargolf','790101-4343'),
	('2016-10-07 12:05:00',0,'Sigges sommargolf','940101-8651'),
	('2014-06-20 12:00:00',72,'Ryder Cup','660808-5555'),
	('2077-07-12 11:56:00',89,'Masters','940101-8651'),
	('2077-07-12 13:12:00',10,'Masters','790101-4343'),
	('2077-07-12 13:55:00',51,'Masters','730909-7777');

# Frågeställningar
SELECT namn 
	FROM domare 
	WHERE pnr='790129-4444';

SELECT signatur 
	FROM boll 
	WHERE pnr='560123-6666';

SELECT typ 
	FROM golfbag 
    WHERE pnr='560123-6666';

SELECT spelare.namn 
	FROM spelare, boll 
    WHERE boll.pnr=spelare.pnr AND boll.marke='Titleist';

SELECT speltillfälle.resultat
	FROM speltillfälle, spelare, boll 
    WHERE speltillfälle.pnr=spelare.pnr AND spelare.pnr=boll.pnr AND boll.marke='Nike';

SELECT spelare.pnr
	FROM spelare, spelare as bspelare 
    WHERE spelare.namn=bspelare.namn AND spelare.pnr!=bspelare.pnr;

SELECT domare.pnr
	FROM domare
    WHERE NOT EXISTS(SELECT ansvara.pnr FROM ansvara WHERE domare.pnr=ansvara.pnr);
    
SELECT caddy.favTips
	FROM caddy, speltillfälle
    WHERE caddy.spelPnr='660808-5555' AND speltillfälle.pnr='660808-5555' AND speltillfälle.resultat='72' AND speltillfälle.namn='Ryder Cup';
    
SELECT spelare.*
	FROM spelare, speltillfälle
    WHERE spelare.pnr=speltillfälle.pnr;

SELECT domare.*
	FROM domare, ansvara
    WHERE domare.pnr=ansvara.pnr
    GROUP BY domare.pnr
    HAVING COUNT(*)=2;

SELECT *
	FROM golfbag
    ORDER BY golfbag.marke DESC;
	
SELECT AVG(resultat) AS Medelresultat
	FROM speltillfälle;
    
SELECT tavling.namn AS Tävling, AVG(speltillfälle.resultat) AS Medelresultat
	FROM tavling, speltillfälle
    WHERE tavling.namn=speltillfälle.namn
    GROUP BY tavling.namn;
    
SELECT *
	FROM klubba
    WHERE klubba.namn LIKE 'J%';

SELECT spelare.namn
	FROM spelare, speltillfälle
    WHERE speltillfälle.namn='Masters' AND spelare.pnr=speltillfälle.pnr
    ORDER BY speltillfälle.resultat ASC
    LIMIT 1;
    
SELECT spelare.namn
	FROM spelare, speltillfälle
    WHERE speltillfälle.resultat=0 AND spelare.pnr=speltillfälle.pnr;

SELECT *
	FROM speltillfälle
    WHERE speltillfälle.starttid BETWEEN '2077-07-10' AND '2077-07-17';

SET SQL_SAFE_UPDATES=0;

UPDATE domare
    SET lon=lon*1.03
    WHERE lon BETWEEN 10000 AND 12000;

DELETE FROM caddy
    WHERE favTips='Sluta stirra';

DELETE FROM golfbag
	WHERE marke='Titleist' AND pnr='560123-6666';

SET SQL_SAFE_UPDATES=1;