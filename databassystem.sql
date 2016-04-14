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
	favTips varchar(20),
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

# Domare
insert into domare values('790129-4444',12000,'Simon');
insert into domare values('810912-5555',12000,'Sven');
insert into domare values('850906-3597',12000,'Jens');
insert into domare values('770202-3333',12000,'Göran');

# Spelare
insert into spelare values('940101-8651','Stina');
insert into spelare values('670808-2222','Sune');
insert into spelare values('790101-4343','Benny');
insert into spelare values('560123-6666','Bosse');
insert into spelare values('730909-1111','Reidar');

# Golfbag
insert into golfbag values('Super','Boom','940101-8651');
insert into golfbag values('Gogo','Superbrand','670808-2222');
insert into golfbag values('Tour','Nike','730909-1111');
insert into golfbag values('Wooow','Devil','560123-6666');

# Klubba
insert into klubba values('Dudle','Säkra bettan','940101-8651','Boom');
insert into klubba values('Driver','Längst och snedast på touren','940101-8651','Boom');
insert into klubba values('Driver','Spikrak och kort','730909-1111','Nike');

# Caddy
insert into caddy values('891010-5468','Knyt skorna hårdare','Anna','670808-2222','Superbrand');
insert into caddy values('461224-4385','Svinga lugnt','Petra','940101-8651','Boom');

# Boll
insert into boll values('Hjärta',null,'Titleist','670808-2222');
insert into boll values('Tre prickar',null,'Titleist','790101-4343');
insert into boll values('Superball',null,'Nike','940101-8651');
insert into boll values('Randig',null,'Kina','560123-6666');

# Speltillfälle
insert into speltillfälle values('2016-10-07 13:10:00','72','Sigges sommargolf','670808-2222');
insert into speltillfälle values('2016-10-07 10:25:00',null,'Sigges sommargolf','560123-6666');
insert into speltillfälle values('2016-10-07 14:10:00','Diskad','Sigges sommargolf','790101-4343');
insert into speltillfälle values('2016-10-07 12:05:00','Diskad','Sigges sommargolf','940101-8651');

# Frågeställningar
select namn from domare where pnr='790129-4444';

select signatur from boll where pnr='560123-6666';

select typ from golfbag where pnr='560123-6666';

select spelare.namn from spelare, boll where boll.pnr=spelare.pnr AND boll.marke='Titleist';

select speltillfälle.resultat from speltillfälle, spelare, boll where speltillfälle.pnr=spelare.pnr AND spelare.pnr=boll.pnr AND boll.marke='Nike';

select spelare.pnr from spelare, spelare where spelare.pnr=spelare.pnr;