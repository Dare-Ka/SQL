create table if not exists Genre (
		id SERIAL primary key,
		title VARCHAR(10) not NULL);
	
create table if not exists Artist (
		id SERIAL primary key,
		nickname VARCHAR(15) not null);
		
create table if not exists Albums (
		id SERIAL primary key,
		title VARCHAR(15) not null,
		year INTEGER);
		
create table if not exists Track(
		id SERIAL primary key,
		title VARCHAR(20) not null,
		duration integer,
		album_id INTEGER references Albums(id));
		
create table if not exists Collection (
		id SERIAL primary key,
		title VARCHAR(30) not null,
		year integer);

create table if not exists ArtistGenre(
		id serial primary key,
		artist_id integer not null references Artist(id),
		genre_id integer not null references Genre(id));

create table if not exists ArtistAlbums(
		id serial primary key,
		artist_id integer references Artist(id),
		albums_id integer references Albums(id));
	
create table if not exists TrackCollection(
		id serial primary key,
		track_id integer references Track(id),
		collection_id integer references Collection(id));

-- Задание №1	

insert into Genre(title)
	values
	('Blues'),
	('Country'),
	('Pop'),
	('Rock'),
	('Metal');
	
insert into Artist(nickname)
	values
	('B.B.King'),
	('Orville Peck'),
	('Michael Jackson'),
	('Buck Tick'),
	('David Bowie');

insert into Albums(title, year)
	values
	('Aku no Hana', 1990),
	('Heroes', 1977),
	('Pony', 2019);

insert into Track(title, duration, album_id)
	values
	('Aku no Hana', 258, 1),
	('My funny Valentine', 279, 1),
	('Love Me', 195, 1),
	('Heroes', 367, 2),
	('Blackout', 230, 2),
	('Dead of Night', 239, 3),
	('Turn to Hate', 294, 3),
	('My funny Valentine', 279, 1),
	('Living myself', 250, 3)

insert into Collection(title, year)
	values
	('Sad morning', 2019),
	('Get well', 2000),
	('No one', 2020),
	('Lost on you', 2005);

insert into ArtistGenre(artist_id, genre_id)
	values
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 4);

insert into ArtistAlbums(artist_id, albums_id)
	values
	(4, 1),
	(5, 2),
	(2, 3);

insert into TrackCollection(track_id, collection_id)
	values
	(1, 1),
	(2, 2),
	(6, 3),
	(3, 4);

-- Задание №2
select title, duration  from track 
where duration = (select max(duration) from track);

select title  from track
where duration >= 3.5*60;

select title from Collection
where 2018 <= year and year <= 2020;

select nickname from artist
where nickname not like '% %';

select title from track
where title ilike 'мой %'
or title ilike '% мой'
or title ilike '% мой %'
or title ilike 'мой'
or title ilike 'my %'
or title ilike '% my'
or title ilike '% my %'
or title ilike 'my';

-- Задание 3
select  count(track.id) from track 
join albums on track.album_id = albums.id 
where albums.year between 2019 and 2020;

select title, count(track_id) from trackalbums t 
join albums a on t.albums_id  = a.id and  a."year" between 2019 and 2020
group by a.title;

select a.title, avg(duration) from track
join albums a on track.album_id  = a.id 
group by a.title;

select nickname from artist
where artist.nickname not in (
	select nickname from artist
	join artistalbums on artist.id = artistalbums.artist_id
	join albums on albums.id = artistalbums.albums_id
	where albums.year = 2020
);

select distinct c.title from collection c 
join trackcollection on c.id = trackcollection.collection_id 
join track t on t.id = trackcollection.track_id 
join artistalbums  on t.album_id = artistalbums.albums_id 
join artist on artist.id = artistalbums.artist_id 
where artist.nickname = 'Buck Tick';