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

-- Like чувствтелен к регистру, ILike - нет
SELECT e.id,
       e.first_name f_name,
       e.last_name  l_name,
       e.salary     _salary
FROM company_storage.employee e
-- WHERE e.salary::numeric != 1000 -- где ЗП не равна 1000
-- WHERE e.first_name LIKE 'Pet%'-- где имя начинается на Pet
-- WHERE e.last_name LIKE '%va'-- где фамилия заканчивается на va
WHERE e.first_name ILIKE '%ET%' -- где имя содержит ET независимо от регистра
ORDER BY e.first_name, e.salary DESC;

SELECT *
FROM company_storage.employee e
WHERE e.salary::NUMERIC BETWEEN 1000 AND 1500;

SELECT *
FROM company_storage.employee e
WHERE e.salary::NUMERIC IN (1500, 2100);

SELECT *
FROM company_storage.employee e
WHERE e.salary::NUMERIC IN (1000, 2000, 2100)
  AND e.first_name ILIKE '%etr%';

SELECT *
FROM company_storage.employee e
WHERE e.salary::NUMERIC IN (1000, 2000, 2100)
   OR e.first_name ILIKE '%etr%'
ORDER BY e.salary;

SELECT *
FROM company_storage.employee e
WHERE e.salary::NUMERIC IN (1000, 2000, 2100)
   OR (e.last_name ILIKE '%ov%'
    AND e.first_name ILIKE 'pet%')
ORDER BY e.salary;