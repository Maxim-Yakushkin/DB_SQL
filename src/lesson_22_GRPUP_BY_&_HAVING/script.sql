CREATE DATABASE company_repository;

CREATE SCHEMA company_storage;

SET SEARCH_PATH = company_storage;

CREATE TABLE company_storage.company
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL
);

CREATE TABLE company_storage.employee
(
    id         BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    company_id BIGINT REFERENCES company_storage.company (id) ON DELETE CASCADE
);

CREATE TABLE company_storage.contact
(
    id     BIGSERIAL PRIMARY KEY,
    number VARCHAR(128) UNIQUE NOT NULL,
    type   VARCHAR(128)
);

CREATE TABLE company_storage.employee_contact
(
    employee_id BIGINT REFERENCES company_storage.employee (id),
    contact_id  BIGINT REFERENCES company_storage.contact (id),
    PRIMARY KEY (employee_id, contact_id)
);

INSERT INTO company_storage.company (name)
VALUES ('Google'),
       ('Yandex'),
       ('Yahoo'),
       ('Amazon'),
       ('Apple')
RETURNING *;

INSERT INTO company_storage.employee (first_name, last_name, company_id)
VALUES ('Ivan', 'Ivanov', 1),
       ('Petr', 'Petrov', 1),
       ('Oleg', 'Olegov', 2),
       ('Sveta', 'Svetikova', 2),
       ('Vika', 'Vikova', 3),
       ('Sergey', 'Sergeev', 1),
       ('Pasha', 'Pashev', 3),
       ('Sasha', 'Sashev', 4),
       ('Artem', 'Artemov', 5)
RETURNING *;

INSERT INTO company_storage.contact (number, type)
VALUES ('134-55-53', 'мобильный'),
       ('234-32-22', 'офисный'),
       ('334-76-24', 'домашний'),
       ('434-54-88', 'домашний'),
       ('534-32-53', 'мобильный'),
       ('634-45-77', 'мобильный'),
       ('734-32-43', 'мобильный'),
       ('834-34-34', 'офисный'),
       ('934-32-32', 'мобильный'),
       ('114-83-11', 'домашний'),
       ('124-56-22', 'офисный'),
       ('134-17-33', 'мобильный')
RETURNING *;

INSERT INTO company_storage.employee_contact (employee_id, contact_id)
VALUES (1, 2),
       (2, 3),
       (3, 1),
       (4, 4),
       (5, 6),
       (6, 5),
       (7, 8),
       (8, 7),
       (9, 9),
       (1, 11),
       (3, 11),
       (9, 12),
       (4, 9),
       (7, 10)
RETURNING *;


-- найти количество сотрудников у заданной компании и сгрупировать (схлопнуть) по id
SELECT company.name,
       count(*)
FROM company
         JOIN employee e
              ON company.id = e.company_id
WHERE company.name = 'Samsung'
GROUP BY company.id;

-- найти количество сотрудников у каждой компании
SELECT company.name,
       count(e.id)
FROM company
         LEFT JOIN employee e
              ON company.id = e.company_id
GROUP BY company.id;

-- найти компании с количеством сотрудников больше 1
-- HAVING это как WHERE, но только после GROUP BY
SELECT company.name,
       count(e.id)
FROM company
         LEFT JOIN employee e
                   ON company.id = e.company_id
GROUP BY company.id
HAVING count(e.id) > 1;