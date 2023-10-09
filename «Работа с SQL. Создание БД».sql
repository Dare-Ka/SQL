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

	