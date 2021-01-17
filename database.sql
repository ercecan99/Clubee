/*
*   CREATE TABLE
*       USERS
*       CLUBS
*       CLUB ADMINS
*       CLUB MANAGERS
*       MEMBERS
*       ANNOUNCEMENTS
*       EVENTS
*       COMMENTS
*/


CREATE TABLE users (
id SERIAL PRIMARY KEY,
email VARCHAR UNIQUE,
name VARCHAR(30) NOT NULL, 
surname VARCHAR(30) NOT NULL, 
student_id CHAR(9) UNIQUE NOT NULL, 
department VARCHAR (150) NOT NULL, 
password_hash VARCHAR NOT NULL
);


CREATE TABLE clubs (
id SERIAL PRIMARY KEY,
name VARCHAR(100) UNIQUE NOT NULL, 
description TEXT,
history TEXT,
student_count INTEGER DEFAULT 0,
source VARCHAR, 
mission TEXT,
vision TEXT,
image_url TEXT
);


CREATE TABLE club_admins (
id SERIAL PRIMARY KEY,
nickname VARCHAR(50) UNIQUE NOT NULL, 
password_hash VARCHAR NOT NULL
);


CREATE TABLE club_managers(
admin_id INTEGER NOT NULL,
club_id INTEGER NOT NULL,
PRIMARY KEY (admin_id, club_id),
FOREIGN KEY (admin_id) REFERENCES club_admins (id)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (club_id) REFERENCES clubs (id)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE members (
user_id INTEGER NOT NULL,
club_id INTEGER NOT NULL,
PRIMARY KEY (user_id, club_id),
FOREIGN KEY (user_id) REFERENCES users (id) 
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (club_id) REFERENCES clubs (id) 
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE announcements (
id SERIAL PRIMARY KEY,
club_id INTEGER NOT NULL REFERENCES clubs (id) 
ON DELETE CASCADE
ON UPDATE CASCADE,
header TEXT NOT NULL,
content TEXT NOT NULL,
blob_image BYTEA,
created_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE events (
id SERIAL PRIMARY KEY,
club_id INTEGER NOT NULL REFERENCES clubs (id) 
ON DELETE CASCADE
ON UPDATE CASCADE,
header TEXT NOT NULL,
content TEXT NOT NULL,
date_ DATE,
blob_image BYTEA,
created_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE comments (
id SERIAL PRIMARY KEY,
event_id INTEGER NOT NULL,
user_id INTEGER NOT NULL,
content TEXT NOT NULL,
created_at TIMESTAMP DEFAULT NOW() NOT NULL,
FOREIGN KEY (event_id) REFERENCES events (id) 
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (user_id) REFERENCES users (id) 
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE areas (
    club_id INTEGER NOT NULL,
    area VARCHAR(30) NOT NULL,
    PRIMARY KEY (club_id, area),
    FOREIGN KEY (club_id) REFERENCES clubs (id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);