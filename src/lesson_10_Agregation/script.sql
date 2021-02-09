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
    salary     MONEY        NOT NULL
);

DROP TABLE company_storage.employee;

INSERT INTO company_storage.employee(first_name, last_name, salary)
VALUES ('Ivan', 'Ivanov', 1000),
       ('Petr', 'Petrov', 2000),
       ('Petr', 'Sidorov', 2100),
       ('Sveta', 'Svetikova', 1500);

-- сумма ЗП всех сотрудников
SELECT sum(e.salary)
FROM company_storage.employee e;

-- средняя ЗП всех сотрудников
SELECT avg(e.salary::NUMERIC)
FROM company_storage.employee e;

-- min ЗП всех сотрудников
SELECT min(e.salary)
FROM company_storage.employee e;

-- max ЗП всех сотрудников
SELECT max(e.salary)
FROM company_storage.employee e;

-- количество записей ЗП NOT NULL
SELECT count(e.salary)
FROM company_storage.employee e;

SELECT upper(e.first_name),
       lower(e.last_name)
FROM company_storage.employee e;

-- конкатинация строк
SELECT e.id,
--        concat(e.first_name, ' ', e.last_name) full_name
       e.first_name || ' ' || e.last_name full_name
FROM company_storage.employee e;

-- имя и текущее время по серверу
SELECT e.first_name || ' ' || e.last_name full_name,
       now() _time
FROM company_storage.employee e;

SELECT now() current_time_server,
       1*2+3 result;