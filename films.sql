CREATE DATABASE film;
CREATE DATABASE

CREATE TABLE films(
    pk_film_id SERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL
);

INSERT INTO films(title)
VALUES
('Joker'),
('Avengers: Endgame'),
('Parasite');

CREATE TABLE film_reviews(
    pk
);