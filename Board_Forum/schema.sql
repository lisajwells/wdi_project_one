CREATE TABLE categories (
id serial primary key,
name varchar(50),
description varchar(255),
vote_up integer,
vote_down integer
);

CREATE TABLE posts(
id serial primary key,
category_id integer,
created_at timestamp,
expiration date,
subject varchar(50),
content text,
vote_up integer,
vote_down integer
);

CREATE TABLE comments(
id serial primary key,
content text,
post_id integer
);

CREATE TABLE subscribers(
id serial primary key,
email varchar(100),
kind varchar(20),
foreign_key integer
);