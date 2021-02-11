SET SEARCH_PATH = flight_storage;

SELECT id
FROM ticket
WHERE id = 29;

CREATE INDEX unique_flight_id_seat_no_idx ON ticket(flight_id,seat_no);

SELECT *
FROM ticket
WHERE flight_id=5
AND seat_no='B1';