CREATE DATABASE book_repository;

CREATE SCHEMA book_storage;

CREATE TABLE book_storage.author
(
    id         BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    UNIQUE (first_name, last_name)
);

CREATE TABLE book_storage.book
(
    id           BIGSERIAL PRIMARY KEY,
    name         VARCHAR(128) UNIQUE NOT NULL,
    year_present DATE                NOT NULL,
    page_count   INT                 NOT NULL,
    author_id    BIGINT REFERENCES book_storage.author (id)
);

-- Заполнить таблицу авторов данными (5+ записей)
INSERT INTO book_storage.author (first_name, last_name)
VALUES ('Уильям', 'Шекспир'),
       ('Джек', 'Лондон'),
       ('Николай', 'Гоголь'),
       ('Рэй', 'Брэндбери'),
       ('Брэм', 'Стокер');

-- Заполнить таблицу книг данными (10+ записей)
INSERT INTO book_storage.book (name, year_present, page_count, author_id)
VALUES ('Гамлет', '1623-01-01', 277, 1),
       ('Король Лир', '1608-01-01', 307, 1),
       ('Белый Клык', '1906-01-01', 251, 2),
       ('Морской Волк', '1904-01-01', 272, 2),
       ('Ревизор', '1836-01-01', 500, 3),
       ('Шинель', '1842-01-01', 499, 3),
       ('Вино из одуванчиков', '1957-01-01', 377, 4),
       ('Лето, прощай', '2006-01-01', 844, 4),
       ('Сокровище семи звезд', '2010-01-01', 222, 5),
       ('Тайна золотистых прядей', '2009-01-01', 777, 5);

-- Написать запрос, выбирающий: название книги, год и имя автора, отсортированные по году издания книги в возрастающем порядке.
-- Написать тот же запрос, но для убывающего порядка.
SELECT b.name,
       b.year_present,
       (SELECT a.first_name || ' ' || a.last_name FROM book_storage.author a WHERE a.id = b.author_id)
FROM book_storage.book b
ORDER BY b.year_present;
-- ORDER BY b.year_present DESC;

-- Написать запрос, выбирающий количество книг у заданного автора.
SELECT count(*)
FROM book_storage.book b
WHERE b.author_id = 1;

-- Написать запрос, выбирающий книги, у которых количество страниц больше среднего количества страниц по всем книгам
SELECT (SELECT concat(a.first_name, ' ', a.last_name) FROM book_storage.author a WHERE a.id = b.author_id),
       b.name,
       b.page_count,
       (SELECT avg(page_count) FROM book_storage.book) avg_page
FROM book_storage.book b
WHERE b.page_count > (SELECT avg(page_count) FROM book_storage.book);

-- Написать запрос, выбирающий 5 самых старых книг
SELECT page_count
FROM book_storage.book
ORDER BY year_present
LIMIT 5;

-- Дополнить запрос и посчитать суммарное количество страниц среди этих книг
SELECT sum(oldest_books.page_count)
FROM (SELECT *
      FROM book_storage.book
      ORDER BY year_present
      LIMIT 5) oldest_books;

-- Написать запрос, изменяющий количество страниц у одной из книг
UPDATE book_storage.book
SET page_count = 1000
WHERE id = 2
RETURNING *;

-- Написать запрос, удаляющий автора, который написал самую большую книгу
DELETE
FROM book_storage.book
WHERE author_id = (SELECT author_id
                   FROM book_storage.book
                   WHERE page_count = (SELECT max(page_count)
                                       FROM book_storage.book));

DELETE
FROM book_storage.author
WHERE id = 1;

SELECT author_id
FROM book_storage.book
WHERE page_count = (SELECT max(page_count)
                    FROM book_storage.book);

SELECT max(page_count)
FROM book_storage.book;