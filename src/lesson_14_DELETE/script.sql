CREATE TABLE company_storage.company
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE UNIQUE         NOT NULL CHECK ( date > '1995-01-01' AND date < '2020-01-01')
);

DROP TABLE company_storage.company;

CREATE TABLE company_storage.employee
(
    id         BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    salary     MONEY,
    company_id BIGINT REFERENCES company_storage.company (id) ON DELETE CASCADE -- при удалении компании с id так же удаляются и сотрудники этой компании
);

DROP TABLE company_storage.employee;

SELECT *
FROM company_storage.employee;

-- удаление сотрудников без ЗП
DELETE
FROM company_storage.employee e
WHERE e.salary IS NULL;

-- удаление сотрудника с самой большой ЗП
DELETE
FROM company_storage.employee
WHERE salary = (SELECT max(salary) FROM company_storage.employee);

-- с удалением этой компании удалятся и сотрудники из employee, т.к. есть констрэйнт ON DELETE CASCADE
DELETE
FROM company_storage.company c
WHERE c.id = 1;

