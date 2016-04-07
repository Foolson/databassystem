drop database d15johol;
create database d15johol;
use d15johol;

# Starka
create table domare(
	pnr char(13),
	lon char(13),
	namn varchar(20),
	primary key(pnr)
)engine=innodb;

create table tavling(
	namn varchar(20),
	datum datetime,
	primary key(namn)
)engine=innodb;

create table spelare(
	pnr char(13),
	namn varchar(20),
	primary key(pnr)
)engine=innodb;

create table boll(
	signatur varchar(20),
	nr char(13),
	marke varchar(20),
	primary key(signatur)
)engine=innodb;

create table caddy(
	pnr char(13),
	favTips varchar(20),
	namn varchar(20),
	primary	key(pnr)
)engine=innodb;

# Svaga
create table speltillfälle(
	starttid varchar(20),
	resultat char(13),
	namn varchar(20),
	pnr char(13),
	primary key(starttid, namn, pnr),
	foreign key(namn) references tavling(namn),
	foreign key(pnr) references spelare(pnr)
)engine=innodb;

create table golfbag(
	typ varchar(20),
	marke varchar(20),
	pnr char(13),
	primary key(marke, pnr),
	foreign key(pnr) references spelare(pnr)
)engine=innodb;

create table klubba(
	namn varchar(20),
	kommentar varchar(20),
	pnr char(13),
	marke varchar(20),
	primary key(namn, pnr, marke),
	foreign key(pnr) references spelare(pnr),
	foreign key(marke) references golfbag(marke)
)engine=innodb;
