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

-- выводит только уникальные значения
SELECT DISTINCT e.first_name AS f_name
FROM company_storage.employee e;

-- выводит только первые 2 записи
SELECT e.id,
       e.first_name f_name,
       e.last_name  l_name,
       e.salary     _salary
FROM company_storage.employee e
LIMIT 2;

-- пропускает 2 записи
SELECT e.id,
       e.first_name f_name,
       e.last_name  l_name,
       e.salary     _salary
FROM company_storage.employee e
    OFFSET 2;

-- сортировка по имени и убыванию ЗП
SELECT e.id,
       e.first_name f_name,
       e.last_name  l_name,
       e.salary     _salary
FROM company_storage.employee e
ORDER BY e.first_name, e.salary DESC;

-- сортировка по имени и убыванию ЗП, пропуская 1 запись и выводя только первые 2 записи
SELECT e.id,
       e.first_name f_name,
       e.last_name  l_name,
       e.salary     _salary
FROM company_storage.employee e
ORDER BY e.first_name, e.salary DESC
OFFSET 1
LIMIT 2;