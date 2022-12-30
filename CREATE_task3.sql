CREATE TABLE genre
(
	genre_ID int  PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE performer
(
	performer_ID int PRIMARY KEY,
	performer_name text NOT NULL
);

CREATE TABLE genre_performer
(
	fk_genre_ID int REFERENCES genre(genre_ID) NOT NULL,
	fk_performer_ID int REFERENCES performer(performer_ID) NOT NULL,
	CONSTRAINT pk_genre_performer PRIMARY KEY(fk_genre_ID,fk_performer_ID)
);

CREATE TABLE album
(
	album_ID int PRIMARY KEY,
	album_name TEXT NOT NULL,
	year_of_production varchar(4)
);

CREATE TABLE performer_album
(
	fk_performer_ID int REFERENCES performer(performer_ID) NOT NULL,
	fk_album_ID int REFERENCES album(album_ID) NOT NULL,
	CONSTRAINT pk_performer_album PRIMARY KEY(fk_performer_ID,fk_album_ID)
);

CREATE TABLE track
(
	track_ID int PRIMARY KEY,
	track_name TEXT NOT NULL,
	length_track time,
	fk_album_ID int REFERENCES album(album_ID) NOT NULL,
	fk_performer_ID int REFERENCES performer(performer_ID) NOT NULL
);

CREATE TABLE collection
(
	collection_ID int PRIMARY KEY,
	collection_name TEXT NOT NULL,
	year_of_production varchar(4)
);

CREATE TABLE track_collection
(
	fk_track_ID int REFERENCES track(track_ID) NOT NULL,
	fk_collection_ID int REFERENCES collection(collection_ID) NOT NULL,
	CONSTRAINT pk_track_collection PRIMARY KEY (fk_track_ID, fk_collection_ID)
);
