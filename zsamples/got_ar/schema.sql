CREATE TABLE houses(
  name varchar(255),
  region varchar(255),
  id serial primary key,
  sigil_url text
);

CREATE TABLE characters(
  name varchar(255),
  image_url text,
  id serial primary key,
  house_id integer
);