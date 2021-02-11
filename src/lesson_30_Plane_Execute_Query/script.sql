SET SEARCH_PATH = flight_storage;

SELECT *
FROM ticket;

EXPLAIN
SELECT *
FROM ticket
WHERE passenger_name ILIKE 'Иван%'
  AND seat_no = 'B1';

EXPLAIN
SELECT flight_id, count(*), sum(cost)
FROM ticket
GROUP BY flight_id;

-- хранит в себе статистические данные о таблицах
SELECT *
FROM pg_class
WHERE relname = 'ticket';