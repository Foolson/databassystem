drop database d15johol;
create database d15johol;
use d15johol;

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