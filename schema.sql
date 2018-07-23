DROP TABLE clients;

CREATE TABLE clients (
    id SERIAL4 PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    preferred_name VARCHAR(100),
    title VARCHAR(50),
    email VARCHAR(300),
    dob DATE,
    phone VARCHAR(15),
    password_digest VARCHAR(400),
    photo VARCHAR(600),
    active BOOLEAN NOT NULL,
    last_update TIMESTAMP,
    date_created TIMESTAMP
);