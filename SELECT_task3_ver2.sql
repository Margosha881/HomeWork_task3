--количество исполнителей в каждом жанре;

SELECT g."name" ,count(gp.fk_performer_id)
FROM genre g
FULL JOIN genre_performer gp  ON g.genre_id = gp.fk_genre_id 
GROUP BY g."name" ;

--количество треков, вошедших в альбомы 2019-2020 годов;

SELECT a.album_name , count(t.track_id)
FROM track t 
FULL JOIN album a ON t.fk_album_id  =a.album_id
WHERE a.year_of_production BETWEEN '2019' AND '2020'
GROUP BY a.album_name ;

--средняя продолжительность треков по каждому альбому;

SELECT a.album_name , avg(t.length_track)
FROM track t 
FULL JOIN album a ON t.fk_album_id  =a.album_id
GROUP BY a.album_name;

--все исполнители, которые не выпустили альбомы в 2020 году;

WITH performer_album AS (
	SELECT DISTINCT p.performer_name, a.year_of_production ye
	FROM performer p 
	JOIN performer_album pa ON p.performer_id = pa.fk_performer_id
	JOIN album a ON a.album_id = pa.fk_album_id)
SELECT DISTINCT performer_name 
FROM performer_album
WHERE performer_name NOT IN (SELECT performer_name FROM performer_album WHERE ye = '2020');

--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);

SELECT c.collection_name 
FROM collection c 
JOIN track_collection tc ON c.collection_id = tc.fk_collection_id 
JOIN track t ON t.track_id = tc.fk_track_id 
JOIN album a ON a.album_id = t.fk_album_id 
JOIN performer_album pa ON pa.fk_album_id = a.album_id 
JOIN performer p ON p.performer_id = pa.fk_performer_id 
WHERE p.performer_name = 'Loc-Dog';

--название альбомов, в которых присутствуют исполнители более 1 жанра;

SELECT a.album_name 
FROM album a 
JOIN performer_album pa ON pa.fk_album_id = a.album_id 
JOIN performer p ON p.performer_id = pa.fk_performer_id 
JOIN genre_performer gp ON gp.fk_performer_id = p.performer_id 
JOIN genre g ON g.genre_id = gp.fk_genre_id 
GROUP BY a.album_name 
HAVING count(DISTINCT g."name") > 1 ;

--наименование треков, которые не входят в сборники;

SELECT t.track_name 
FROM track t 
LEFT JOIN track_collection tc ON tc.fk_track_id = t.track_id 
WHERE tc.fk_track_id IS NULL ;

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);

SELECT p.performer_name 
FROM performer p 
LEFT JOIN track t ON t.fk_performer_id = p.performer_id 
WHERE t.length_track <= (SELECT min(DISTINCT length_track) FROM track);

--название альбомов, содержащих наименьшее количество треков.

WITH track_count AS (
	SELECT a.album_name, count (t.track_name) cnt
	FROM track t 
	LEFT JOIN album a ON a.album_id = t.fk_album_id
	GROUP BY a.album_name)
SELECT album_name
FROM track_count
WHERE cnt <=(SELECT min(cnt) FROM track_count);






