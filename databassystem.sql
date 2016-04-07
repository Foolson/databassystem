drop database d15johol;
create database d15johol;
use d15johol;

# Skapa starka
create table domare(
	pnr char(11),
	lon char(13),
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

create table caddy(
	pnr char(11),
	favTips varchar(20),
	namn varchar(20),
	primary	key(pnr)
)engine=innodb;

# Skapa svaga
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
	cadPnr char(11),
	primary key(marke, pnr),
	foreign key(pnr) references spelare(pnr),
	foreign key(cadPnr) references caddy(pnr)
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

# Transaktioner
insert into tavling values('Sigges sommargolf','2016-10-07');