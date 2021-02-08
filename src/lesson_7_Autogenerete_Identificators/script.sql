CREATE TABLE company_storage.company
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE UNIQUE         NOT NULL CHECK ( date > '1995-01-01' AND date < '2020-01-01')
);

CREATE TABLE company_storage.employee
(
    id         BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    salary     MONEY        NOT NULL,
    UNIQUE (first_name, last_name) -- именно конкотенация этих полей должна быть уникальна. Последовательность поелй важна
);

DROP TABLE company_storage.employee;

INSERT INTO company_storage.employee(first_name, last_name, salary)
VALUES ('Ivan', 'Ivanov', 1000),
       ('Petr', 'Petrov', 2000),
       ('Sveta', 'Svetikova', 1500);

SELECT *
FROM company_storage.employee;

SELECT concat('BYN ', e.salary::NUMERIC)
FROM company_storage.employee e

