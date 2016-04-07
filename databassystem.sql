drop database d15johol;
create database d15johol;
use d15johol;

create table spelare(
	pnr char(13),
	namn varchar(20),
	primary key(pnrspelare)
)engine=innodb;