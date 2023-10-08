create table if not exists Genre (
		id SERIAL primary key,
		title VARCHAR(10) not NULL);
	
create table if not exists Artist (
		id SERIAL primary key,
		nickname VARCHAR(15) not null,
		genre_id INTEGER not null references Genre(id));
		
create table if not exists Albums (
		id SERIAL primary key,
		title VARCHAR(15) not null,
		year INTEGER,
		artist_id INTEGER references Artist(id));
		
create table if not exists Track(
		id SERIAL primary key,
		title VARCHAR(20) not null,
		duration numeric,
		album_id INTEGER references Albums(id));
		
create table if not exists Collection (
		id SERIAL primary key,
		title VARCHAR(30) not null,
		year integer,
		track_id INTEGER references Track(id));

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

	create table if not exists TrackAlbums (
			id serial primary key,
			track_id integer references Track(id),
			albums_id integer references Albums(id));

-- Задание №1	

insert into Genre(title)
	values
	('Blues'),
	('Country'),
	('Pop'),
	('Rock'),
	('Metal');
	
insert into Artist(nickname, genre_id)
	values
	('B.B.King', 1),
	('Orville Peck', 2),
	('Michael Jackson', 3),
	('Buck Tick', 4),
	('David Bowie', 4);

insert into Albums(title, year, artist_id)
	values
	('Aku no Hana', 1990, 4),
	('Heroes', 1977, 5),
	('Pony', 2019, 2);

insert into Track(title, duration, album_id)
	values
	('Aku no Hana', 258, 1),
	('My funny Valentine', 279, 1)
	('Love Me', 195, 1),
	('Heroes', 367, 2),
	('Blackout', 230, 2),
	('Dead of Night', 239, 3),
	('Turn to Hate', 294, 3);

insert into Collection(title, year, track_id)
	values
	('Sad morning', 2019, 1),
	('Get well', 2000, 2),
	('No one', 2020, 6),
	('Lost on you', 2005, 3);

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

insert into TrackAlbums (track_id, albums_id)
	values
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 2),
	(5, 2),
	(6, 3),
	(7, 3);
-- Задание №2
select title, duration  from track 
where duration = (select max(duration) from track)

select title  from track
where duration >= 3.5*60

select title from Collection
where 2018 <= year and year <= 2020

select nickname from artist
where nickname not like '% %'

insert into track(title, duration, album_id)
	values
	('My funny Valentine', 279, 1)

select title from track
where title like '%Мой%' or title like '%My%'

-- Задание 3
select title, count(artist_id) from artistgenre a 
join genre g  on a.genre_id = g.id 
group by g.title 

select title, count(track_id) from trackalbums t 
join albums a on t.albums_id  = a.id and  a."year" between 2019 and 2020
group by a.title 

select a.title, avg(duration) from track
join albums a on track.album_id  = a.id 
group by a.title 

select nickname from artist
join albums a on a.artist_id = artist.id 
where a."year" != 2020

select c.title from collection c 
join track t on t.id = c.track_id 
join albums a on t.album_id = a.id 
where a.artist_id = (select id from artist where artist.nickname = 'Buck Tick') 



	