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
	resultat char(13),
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
	kommentar varchar(20),
	pnr char(11),
	marke varchar(20),
	primary key(namn, pnr, marke),
	foreign key(pnr) references spelare(pnr),
	foreign key(marke) references golfbag(marke)
)engine=innodb;

create table caddy(
	pnr char(11),
	favTips varchar(20),
	namn varchar(20),
	spelPnr char(11),
	bagMarke varchar(20),
	primary	key(pnr),
	foreign key(spelPnr) references spelare(pnr),
	foreign key(bagMarke) references golfbag(marke)
)engine=innodb;

# Transaktioner
# 1
insert into tavling values('Sigges sommargolf','2016-10-07');

# 2
insert into domare values('790129-4444',12000,'Simon');
insert into domare values('810912-5555',12000,'Sven');

#3
insert into spelare values('560123-6666','Bosse');
insert into speltillfälle values('2016-10-07 10:25:00',null,'Sigges sommargolf','560123-6666');

#4
insert into spelare values('730909-1111','Reidar');
insert into golfbag values('Tour','Nike','730909-1111');

#5
insert into klubba values('Driver','Spikrak och kort','730909-1111','Nike');

#6
insert into spelare values('670808-2222','Sune');
insert into golfbag values('Gogo','Superbrand','670808-2222');
insert into caddy values('891010-5468','Knyt skorna hårdare','Anna','670808-2222','Superbrand');
