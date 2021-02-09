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


-- UNION ALL (как List в Java) объединяет результаты запросов,
-- UNION - объединяет результаты запрсов и исключает дубликаты (как Set в Java)
SELECT e.first_name
FROM company_storage.employee e
WHERE company_id IS NOT NULL
UNION
-- UNION ALL
SELECT e.first_name
FROM company_storage.employee e
WHERE e.salary IS NULL;