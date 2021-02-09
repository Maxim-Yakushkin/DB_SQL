CREATE TABLE company_storage.company
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE UNIQUE         NOT NULL CHECK ( date > '1995-01-01' AND date < '2020-01-01')
);

INSERT INTO company_storage.company(name, date)
VALUES ('Google', '2001-01-01'),
       ('Apple', '2002-10-29'),
       ('Yandex', '2004-11-11'),
       ('Facebook', '1998-09-13');

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

INSERT INTO company_storage.employee(first_name, last_name, salary, company_id)
VALUES ('Ivan', 'Ivanov', 1000, 1),
       ('Petr', 'Petrov', 2000, 2),
       ('Arny', 'Poramonov', NULL, 3),
       ('Petr', 'Sidorov', 2100, 4),
       ('Sveta', 'Svetikova', 1500, NULL);

UPDATE company_storage.employee
SET company_id = 2,
    salary     = 1700
WHERE id = 5
RETURNING *; -- возвращает только что обновленные/удаленные данныне (для информации, типа как SELECT)