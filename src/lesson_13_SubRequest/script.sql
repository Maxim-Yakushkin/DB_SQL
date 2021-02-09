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
    salary     MONEY,
    company_id BIGINT REFERENCES company_storage.company (id)
--     FOREIGN KEY (company_id) REFERENCES company_storage.company (id)
);

DROP TABLE company_storage.employee;

INSERT INTO company_storage.employee(first_name, last_name, salary, company_id)
VALUES ('Ivan', 'Ivanov', 1000, 1),
       ('Petr', 'Petrov', 2000, 2),
       ('Arny', 'Poramonov', NULL, 3),
       ('Petr', 'Sidorov', 2100, 4),
       ('Sveta', 'Svetikova', 1500, NULL);

-- средняя ЗП двух сотрудников с самыми низкими ЗП
SELECT avg(employes.salary::NUMERIC)
FROM (SELECT e.salary
      FROM company_storage.employee e
      ORDER BY e.salary
      LIMIT 2) employes;

-- Подзапросы, добавляющие колонки с max, min и avg ЗП сотрудников
SELECT *,
       (SELECT avg(em.salary::NUMERIC) FROM company_storage.employee em) avg_salary,
       (SELECT max(em.salary) FROM company_storage.employee em)          max_salary,
       (SELECT min(em.salary) FROM company_storage.employee em)          min_salary
FROM company_storage.employee e;

-- Подзапросы, добавляющий колонку с разницей между самой высокой ЗП и ЗП текущего сотрудника
SELECT e.first_name || ' ' || e.last_name                                  full_name,
       (SELECT max(em.salary) FROM company_storage.employee em)            max_salary,
       e.salary                                                            current_salary,
       (SELECT max(em.salary) FROM company_storage.employee em) - e.salary diff_salary
FROM company_storage.employee e;

SELECT *
FROM company_storage.employee e
WHERE e.company_id IN (SELECT com.id
                       FROM company_storage.company com
                       WHERE com.date > '1998-01-01' AND com.date < '2004-01-01');