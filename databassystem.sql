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
	datum datetime,
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
	resultat varchar(20),
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
insert into tavling values('Sigges sommargolf','2016-07-10');
insert into tavling values('Ryder Cup','2014-06-20');

# Domare
insert into domare values('790129-4444',12000,'Simon');
insert into domare values('810912-5555',12000,'Sven');
insert into domare values('790612-1212',12000,'Eva');
insert into domare values('850906-3597',12000,'Jens');
insert into domare values('770202-3333',12000,'Göran');

insert into ansvara values('790129-4444','Sigges sommargolf');
insert into ansvara values('810912-5555','Sigges sommargolf');
insert into ansvara values('790612-1212','Sigges sommargolf');
insert into ansvara values('850906-3597','Ryder Cup');
insert into ansvara values('850906-3597','Sigges sommargolf');

# Spelare
insert into spelare values('940101-8651','Stina');
insert into spelare values('670808-2222','Sune');
insert into spelare values('790101-4343','Benny');
insert into spelare values('560123-6666','Bosse');
insert into spelare values('730909-1111','Reidar');
insert into spelare values('730909-7777','Reidar');
insert into spelare values('660808-5555','Kurt-Evert');

# Golfbag
insert into golfbag values('Super','Boom','940101-8651');
insert into golfbag values('Gogo','SuperbrAND','670808-2222');
insert into golfbag values('Tour','Nike','730909-1111');
insert into golfbag values('Wooow','Devil','560123-6666');
insert into golfbag values('AndroidBag','Google','660808-5555');

# Klubba
insert into klubba values('Dudle','Säkra bettan','940101-8651','Boom');
insert into klubba values('Driver','Längst och snedast på touren','940101-8651','Boom');
insert into klubba values('Driver','Spikrak och kort','730909-1111','Nike');

# Caddy
insert into caddy values('891010-5468','Knyt skorna hårdare','Anna','670808-2222','SuperbrAND');
insert into caddy values('461224-4385','Svinga lugnt','Petra','940101-8651','Boom');
insert into caddy values('551221-9988','Sluta stirra på brudarnas rövar','Jesus','660808-5555','Google');

# Boll
insert into boll values('Hjärta',null,'Titleist','670808-2222');
insert into boll values('Tre prickar',null,'Titleist','790101-4343');
insert into boll values('Superball',null,'Nike','940101-8651');
insert into boll values('RANDig',null,'Kina','560123-6666');

# Speltillfälle
insert into speltillfälle values('2016-10-07 13:10:00','72','Sigges sommargolf','670808-2222');
insert into speltillfälle values('2016-10-07 10:25:00',null,'Sigges sommargolf','560123-6666');
insert into speltillfälle values('2016-10-07 14:10:00','Diskad','Sigges sommargolf','790101-4343');
insert into speltillfälle values('2016-10-07 12:05:00','Diskad','Sigges sommargolf','940101-8651');
insert into speltillfälle values('2014-06-20 12:00:00','72','Ryder Cup','660808-5555');

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

SELECT domare.*
	FROM domare, ansvara
    WHERE domare.pnr=ansvara.pnr
    GROUP BY domare.pnr
    HAVING count(*)=2;

	
    


    