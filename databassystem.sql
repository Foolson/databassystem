drop database d15johol;
create database d15johol;
use d15johol;

# Skapa tabeller
# Skapa tabellen domare
create table domare(
  pnr char(11),
  lon int,
  namn varchar(20),
  primary key(pnr)
)engine=innodb;

# Skapa tabellen tavling
create table tavling(
  namn varchar(20),
  datum date,
  primary key(namn)
)engine=innodb;

# Skapa tabellen ansvara för relationen mellan tavling och domare
create table ansvara(
  pnr char(11),
  namn varchar(20),
  primary key(pnr, namn),
  foreign key(namn) references tavling(namn),
  foreign key(pnr) references domare(pnr)
)engine=innodb;

# Skapa tabellen spelare
create table spelare(
  pnr char(11),
  namn varchar(20),
  primary key(pnr)
)engine=innodb;

# Skapa tabellen boll
create table boll(
  signatur varchar(20),
  nr int,
  marke varchar(20),
  pnr char(11),
  primary key(signatur),
  foreign key(pnr) references spelare(pnr)
)engine=innodb;

# Skapa tabellen speltillfalle
create table speltillfalle(
  starttid datetime,
  resultat int,
  namn varchar(20),
  pnr char(11),
  primary key(starttid, namn, pnr),
  foreign key(namn) references tavling(namn),
  foreign key(pnr) references spelare(pnr)
)engine=innodb;

# Skapa tabellen golfbag
create table golfbag(
  typ varchar(20),
  marke varchar(20),
  pnr char(11),
  primary key(marke, pnr),
  foreign key(pnr) references spelare(pnr)
)engine=innodb;

# Skapa tabellen klubba
create table klubba(
  namn varchar(20),
  kommentar varchar(30),
  pnr char(11),
  marke varchar(20),
  primary key(namn, pnr, marke),
  foreign key(pnr) references spelare(pnr),
  foreign key(marke) references golfbag(marke)
)engine=innodb;

# Skapa tabellen caddy
create table caddy(
  pnr char(11),
  favTips varchar(50),
  namn varchar(20),
  spelPnr char(11),
  bagMarke varchar(20),
  primary key(pnr),
  foreign key(spelPnr) references spelare(pnr),
  foreign key(bagMarke) references golfbag(marke)
)engine=innodb;

# Transaktioner
# Lägg in data i tabellen tavling
insert into tavling values
  ('Sigges sommargolf','2016-07-10'),
  ('Ryder Cup','2014-06-20'),
  ('Masters','2077-07-12');

# Lägg in data i tabellen domare
insert into domare values
  ('790129-4444',12000,'Simon'),
  ('810912-5555',12000,'Sven'),
  ('790612-1212',12000,'Eva'),
  ('850906-3597',12000,'Jens'),
  ('770202-3333',12000,'Göran'),
  ('780203-7785',55000,'Knugen'),
  ('910203-2185',4300,'Gullis');

# Lägg till data i tabellen ansvara för relationen mellan domare och tavling
insert into ansvara values
  ('790129-4444','Sigges sommargolf'),
  ('810912-5555','Sigges sommargolf'),
  ('790612-1212','Sigges sommargolf'),
  ('850906-3597','Ryder Cup'),
  ('850906-3597','Sigges sommargolf');

# Lägg till data i tabellen spelare
insert into spelare values
  ('940101-8651','Stina'),
  ('670808-2222','Sune'),
  ('790101-4343','Benny'),
  ('560123-6666','Bosse'),
  ('730909-1111','Reidar'),
  ('730909-7777','Reidar'),
  ('660808-5555','Kurt-Evert');

# Lägg till data i tabellen golfbag
insert into golfbag values
  ('Super','Boom','940101-8651'),
  ('Gogo','SuperbrAND','670808-2222'),
  ('Tour','Nike','730909-1111'),
  ('Wooow','Titleist','560123-6666'),
  ('AndroidBag','Google','660808-5555');

# Lägg till data i tabellen klubba
insert into klubba values
  ('Dudle','Säkra bettan','940101-8651','Boom'),
  ('Driver','Längst och snedast på touren','940101-8651','Boom'),
  ('Driver','Spikrak och kort','730909-1111','Nike'),
  ('Jensens','Google suger','730909-1111','Nike');

# Lägg till data i tabellen caddy
insert into caddy values
  ('891010-5468','Knyt skorna hårdare','Anna','670808-2222','SuperbrAND'),
  ('461224-4385','Svinga lugnt','Petra','940101-8651','Boom'),
  ('551221-9988','Sluta stirra på brudarnas rövar','Jesus','660808-5555','Google'),
  ('991221-1235','Sluta stirra','Jeppe','560123-6666','Titleist');

# Lägg till data i tabellen boll
insert into boll values
  ('Hjärta',0,'Titleist','670808-2222'),
  ('Tre prickar',0,'Titleist','790101-4343'),
  ('Superball',0,'Nike','940101-8651'),
  ('RANDig',0,'Kina','560123-6666');

# Lägg till data i tabellen speltillfalle
insert into speltillfalle values
  ('2016-10-07 13:10:00',72,'Sigges sommargolf','670808-2222'),
  ('2016-10-07 10:25:00',0,'Sigges sommargolf','560123-6666'),
  ('2016-10-07 14:10:00',0,'Sigges sommargolf','790101-4343'),
  ('2016-10-07 12:05:00',0,'Sigges sommargolf','940101-8651'),
  ('2014-06-20 12:00:00',72,'Ryder Cup','660808-5555'),
  ('2077-07-12 11:56:00',89,'Masters','940101-8651'),
  ('2077-07-12 13:12:00',10,'Masters','790101-4343'),
  ('2077-07-12 13:55:00',51,'Masters','730909-7777');

# Frågeställningar
# Hämta namnet på domaren med personnummret 790129‐4444
SELECT namn
  FROM domare
  WHERE pnr='790129-4444';

# Hämta sugnaturen på bollen som spelades av spelaren med personnummret
# 560123-6666
SELECT signatur
  FROM boll
  WHERE pnr='560123-6666';

# Hämta typen på golfbagen som ägs av spelaren med personnummret 560123-6666
SELECT typ
  FROM golfbag
  WHERE pnr='560123-6666';

# Hämta namnet på spelarna som har bollar med märket 'Titleist'
SELECT spelare.namn
  FROM spelare, boll
  WHERE boll.pnr=spelare.pnr AND
        boll.marke='Titleist';

# Hämta resultaten för speltillfällen som spelades med bollar av märket 'Nike'
SELECT speltillfalle.resultat
  FROM speltillfalle, spelare, boll
  WHERE speltillfalle.pnr=spelare.pnr AND
        spelare.pnr=boll.pnr AND
        boll.marke='Nike';

# Hämta personnummret till de spelare som har samma namn
SELECT spelare.pnr
  FROM spelare, spelare as bspelare
  WHERE spelare.namn=bspelare.namn AND
        spelare.pnr!=bspelare.pnr;

# Hämta personnummret till de fomare som inte ansvarat för någon tävling
SELECT domare.pnr
  FROM domare
  WHERE NOT EXISTS(
              SELECT ansvara.pnr
                FROM ansvara
                WHERE domare.pnr=ansvara.pnr
            );

# Hämta tipset som gavs åt spelarem ned personnummret 660808-5555 som hade
# resultat 72 slag i tävlingen "Ryder Cup"
SELECT caddy.favTips
  FROM caddy, speltillfalle
  WHERE caddy.spelPnr='660808-5555' AND
        speltillfalle.pnr='660808-5555' AND
        speltillfalle.resultat='72' AND
        speltillfalle.namn='Ryder Cup';

# Hämta spelarna som deltagit i ett speltillfälle
SELECT spelare.*
  FROM spelare, speltillfalle
  WHERE spelare.pnr=speltillfalle.pnr;

# Hämta de domare som ansvarat för exakt två tävlingar
SELECT domare.*
  FROM domare, ansvara
  WHERE domare.pnr=ansvara.pnr
  GROUP BY domare.pnr
  HAVING COUNT(*)=2;

# Hämta alla golfbagar sorterat omvänt efter märke
SELECT *
  FROM golfbag
  ORDER BY golfbag.marke DESC;

# Hämta medelresultat för alla speltillfällen
SELECT AVG(resultat) AS Medelresultat
  FROM speltillfalle;

# Hämta medelresultat för alla speltillällen på respektive tävling
SELECT tavling.namn AS Tävling, AVG(speltillfalle.resultat) AS Medelresultat
  FROM tavling, speltillfalle
  WHERE tavling.namn=speltillfalle.namn
  GROUP BY tavling.namn;

# Hämta all data om klubborna som har ett namn som börjar på bokstaven 'j'
SELECT *
  FROM klubba
  WHERE klubba.namn LIKE 'J%';

# Hämta namnet på den spelare som hade bäst resultat i tävlingen 'Masters'
SELECT spelare.namn
  FROM spelare, speltillfalle
  WHERE speltillfalle.namn='Masters' AND
        spelare.pnr=speltillfalle.pnr
  ORDER BY speltillfalle.resultat ASC
  LIMIT 1;

# Hämta namnet på de spelare som inte slutförde sitt speltillfälle
SELECT spelare.namn
  FROM spelare, speltillfalle
  WHERE speltillfalle.resultat=0 AND spelare.pnr=speltillfalle.pnr;

# Lista de spelillfällen som pågick under golfveckan 10/7 - 17/7
SELECT *
  FROM speltillfalle
  WHERE speltillfalle.starttid BETWEEN '2077-07-10' AND
                                       '2077-07-17';

# Gör det möjligt att uppdatera tabeller
SET SQL_SAFE_UPDATES=0;

# Öka lönen på alla domare som tjänar 10000-12000 med tre procent
UPDATE domare
  SET lon=lon*1.03
  WHERE lon BETWEEN 10000 AND 12000;

# Ta bort caddyn som heter jeppe och som alltid ger tipset 'Sluta stirra'
DELETE FROM caddy
  WHERE namn='Jeppe' AND favTips='Sluta stirra';

# Ta bort golfbagen av märket 'Titleist' som tillhör spelaren med personnummret
# 560123-6666
DELETE FROM golfbag
  WHERE marke='Titleist' AND
        pnr='560123-6666';

# Ta bort möjligheten att uppdatera tabeller
SET SQL_SAFE_UPDATES=1;
