DROP TABLE appointment_notes CASCADE;
DROP TABLE appointments CASCADE;
DROP TABLE client_notes CASCADE;
DROP TABLE clients CASCADE;
DROP TABLE emp_work_hours CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE booking_requests CASCADE;

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

CREATE TABLE emp_work_hours (
    id SERIAL4 PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    work_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    author_id INTEGER,
    last_updated TIMESTAMP,
    date_created TIMESTAMP,
    active BOOLEAN NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES employees(id) ON DELETE CASCADE
);

CREATE TABLE appointments (
    id SERIAL4 PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    app_date DATE NOT NULL,
    start_time TIME NOT NULL,
    app_service VARCHAR(100),
    end_time TIME NOT NULL,
    author_id INTEGER,
    last_updated TIMESTAMP,
    date_created TIMESTAMP,
    active BOOLEAN NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES employees(id) ON DELETE CASCADE
);

CREATE TABLE appointment_notes (
    id SERIAL4 PRIMARY KEY,
    appointment_id INTEGER NOT NULL,
    note TEXT NOT NULL,
    author_id INTEGER,
    last_update TIMESTAMP,
    date_created TIMESTAMP,
    active BOOLEAN NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES employees(id) ON DELETE CASCADE
);

CREATE TABLE booking_requests (
    id SERIAL4 PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    client_id INTEGER,
    anon_phone VARCHAR(20),
    anon_name VARCHAR(100),
    app_date DATE NOT NULL,
    start_time TIME NOT NULL,
    app_service VARCHAR(100),
    end_time TIME NOT NULL,
    request_status VARCHAR(20),
    appointment_id INTEGER,
    last_updated TIMESTAMP,
    date_created TIMESTAMP,
    active BOOLEAN NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);
