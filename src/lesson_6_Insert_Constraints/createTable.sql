-- NOT NULL : не нулевое поле
-- UNIQUE : уникальное поле
-- CHECK (  ) : условие добавления записи в поле
-- PRIMARY KEY : первичный ключ, аналог UNIQUE NOT NULL
-- FOREIGN KEY : привязка по ключу

-- 1 вариант указания констрэйнтов
CREATE TABLE company_storage.company
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE UNIQUE         NOT NULL CHECK ( date > '1995-01-01' AND date < '2020-01-01')
);

-- 2 вариант указания констрэйнтов
CREATE TABLE company_storage.company
(
    id   BIGSERIAL,
    name VARCHAR(128) NOT NULL,
    date DATE         NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name, date),
    CHECK ( date > '1995-01-01' AND date < '2020-01-01')
);

DROP TABLE company_storage.company;


INSERT INTO company_storage.company(name, date)
VALUES ('Google', '2001-01-01'),
       ('Apple', '2002-10-29'),
       ('Yandex', '2004-11-11'),
       ('Facebook', '1998-09-13');