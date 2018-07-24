DROP TABLE client_notes;
DROP TABLE clients;
DROP TABLE employees;

CREATE TABLE clients (
    id SERIAL4 PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    preferred_name VARCHAR(100),
    title VARCHAR(50),
    email VARCHAR(300),
    password_digest VARCHAR(400),
    dob DATE,
    phone VARCHAR(15),
    photo VARCHAR(600),
    active BOOLEAN NOT NULL,
    last_update TIMESTAMP,
    date_created TIMESTAMP
);

CREATE TABLE employees (
    id SERIAL4 PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    preferred_name VARCHAR(100),
    title VARCHAR(50),
    email VARCHAR(300),
    password_digest VARCHAR(400),
    dob DATE,
    phone VARCHAR(15),
    photo VARCHAR(600),
    active BOOLEAN NOT NULL,
    terminated BOOLEAN NOT NULL,
    admin BOOLEAN NOT NULL,
    date_started DATE,
    date_terminated DATE,
    last_update TIMESTAMP,
    date_created TIMESTAMP
);

CREATE TABLE client_notes (
    id SERIAL4 PRIMARY KEY,
    client_id INTEGER NOT NULL,
    note TEXT NOT NULL,
    author_id INTEGER,
    last_update TIMESTAMP,
    date_created TIMESTAMP,
    active BOOLEAN NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES employees(id) ON DELETE CASCADE
);

