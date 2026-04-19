-- MOVIE BOOKING SYSTEM — Oracle (freesql.org) compatible
-- All corrections applied. Paste & Run this file to create schema + data + routines.
-- NOTE: Anonymous PL/SQL test blocks are provided at the bottom as commented-out examples — run them one at a time.

SET SERVEROUTPUT ON
/

------------------------------------------------------
-- 1. DROP OLD TABLES (simple SQL drops)
-- freesql.org tolerates errors on DROP; run this whole block first
------------------------------------------------------
DROP TABLE tbl_movie_actor CASCADE CONSTRAINTS;
DROP TABLE tbl_tickets CASCADE CONSTRAINTS;
DROP TABLE tbl_feedback CASCADE CONSTRAINTS;
DROP TABLE tbl_show CASCADE CONSTRAINTS;
DROP TABLE tbl_actor CASCADE CONSTRAINTS;
DROP TABLE tbl_movie CASCADE CONSTRAINTS;
DROP TABLE tbl_theatre CASCADE CONSTRAINTS;
DROP TABLE tbl_customer CASCADE CONSTRAINTS;

------------------------------------------------------
-- 2. CREATE TABLES (Oracle types)
------------------------------------------------------
CREATE TABLE tbl_customer (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(64) NOT NULL,
    phone_number VARCHAR2(20),
    dob DATE,
    email VARCHAR2(64),
    username VARCHAR2(64) UNIQUE NOT NULL,
    password VARCHAR2(256) NOT NULL
);

CREATE TABLE tbl_theatre (
    theatre_id NUMBER PRIMARY KEY,
    theatre_name VARCHAR2(100),
    address VARCHAR2(255)
);

CREATE TABLE tbl_movie (
    movie_id NUMBER PRIMARY KEY,
    movie_name VARCHAR2(100),
    rating VARCHAR2(10),
    release_date DATE,
    director VARCHAR2(100),
    description VARCHAR2(255),
    duration VARCHAR2(20),
    genre VARCHAR2(100)
);

CREATE TABLE tbl_feedback (
    feedback_id NUMBER PRIMARY KEY,
    feedback VARCHAR2(500),
    movie_id NUMBER,
    customer_id NUMBER,
    CONSTRAINT fk_feedback_customer FOREIGN KEY (customer_id) REFERENCES tbl_customer(customer_id),
    CONSTRAINT fk_feedback_movie FOREIGN KEY (movie_id) REFERENCES tbl_movie(movie_id)
);

CREATE TABLE tbl_show (
    show_id NUMBER PRIMARY KEY,
    theatre_id NUMBER,
    movie_id NUMBER,
    show_time TIMESTAMP,
    show_date DATE,
    seats_left NUMBER,
    language VARCHAR2(50),
    CONSTRAINT fk_show_theatre FOREIGN KEY (theatre_id) REFERENCES tbl_theatre(theatre_id),
    CONSTRAINT fk_show_movie FOREIGN KEY (movie_id) REFERENCES tbl_movie(movie_id)
);

CREATE TABLE tbl_tickets (
    ticket_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    show_id NUMBER,
    noOfSeats NUMBER,
    CONSTRAINT fk_tickets_customer FOREIGN KEY (customer_id) REFERENCES tbl_customer(customer_id),
    CONSTRAINT fk_tickets_show FOREIGN KEY (show_id) REFERENCES tbl_show(show_id)
);

CREATE TABLE tbl_actor (
    actor_id NUMBER PRIMARY KEY,
    actor_name VARCHAR2(100),
    gender CHAR(1)
);

CREATE TABLE tbl_movie_actor (
    movie_id NUMBER,
    actor_id NUMBER,
    CONSTRAINT fk_movie_actor_movie FOREIGN KEY (movie_id) REFERENCES tbl_movie(movie_id),
    CONSTRAINT fk_movie_actor_actor FOREIGN KEY (actor_id) REFERENCES tbl_actor(actor_id),
    PRIMARY KEY (movie_id, actor_id)
);

------------------------------------------------------
-- 3. INSERT FIXED DATA
------------------------------------------------------
-- Customers
INSERT INTO tbl_customer VALUES (1, 'John Doe', '1234567890', TO_DATE('1990-05-15','YYYY-MM-DD'),'john@example.com','johndoe','password123');
INSERT INTO tbl_customer VALUES (2, 'Jane Smith','9876543210',TO_DATE('1985-10-20','YYYY-MM-DD'),'jane@example.com','janesmith','password456');
INSERT INTO tbl_customer VALUES (3, 'Alice Johnson','5551234567',TO_DATE('1995-03-25','YYYY-MM-DD'),'alice@example.com','alicej','password789');
INSERT INTO tbl_customer VALUES (4, 'Bob Brown','4447891230',TO_DATE('1982-12-12','YYYY-MM-DD'),'bob@example.com','bobbrown','passwordabc');
INSERT INTO tbl_customer VALUES (5, 'Emily Davis','3335557777',TO_DATE('1998-08-08','YYYY-MM-DD'),'emily@example.com','emilyd','passworddef');

-- Theatres
INSERT INTO tbl_theatre VALUES (200, 'Cineplex Cinemas', '123 Main St, Cityville');
INSERT INTO tbl_theatre VALUES (201, 'Regal Cinemas', '456 Elm St, Townsville');
INSERT INTO tbl_theatre VALUES (202, 'AMC Theatres', '789 Oak St, Villageton');
INSERT INTO tbl_theatre VALUES (203, 'Vue Cinemas', '321 Maple St, Countryside');
INSERT INTO tbl_theatre VALUES (204, 'Odeon Cinemas', '567 Pine St, Mountainview');

-- Movies (FIXED IDs)
INSERT INTO tbl_movie VALUES (501,'The Shawshank Redemption','PG-13',TO_DATE('1994-09-23','YYYY-MM-DD'),'Frank Darabont','...', '2:22','Drama');
INSERT INTO tbl_movie VALUES (502,'The Godfather','R',TO_DATE('1972-03-24','YYYY-MM-DD'),'Francis Ford Coppola','...', '2:55','Crime');
INSERT INTO tbl_movie VALUES (503,'The Dark Knight','PG-13',TO_DATE('2008-07-18','YYYY-MM-DD'),'Christopher Nolan','...', '2:32','Action');
INSERT INTO tbl_movie VALUES (504,'Pulp Fiction','R',TO_DATE('1994-10-14','YYYY-MM-DD'),'Quentin Tarantino','...', '2:34','Crime');
INSERT INTO tbl_movie VALUES (505,'Inception','PG-13',TO_DATE('2010-07-16','YYYY-MM-DD'),'Christopher Nolan','...', '2:28','Action');

-- Actors
INSERT INTO tbl_actor VALUES (51, 'Tom Hanks', 'M');
INSERT INTO tbl_actor VALUES (52, 'Marlon Brando', 'M');
INSERT INTO tbl_actor VALUES (53, 'Heath Ledger', 'M');
INSERT INTO tbl_actor VALUES (54, 'John Travolta', 'M');
INSERT INTO tbl_actor VALUES (55, 'Leonardo DiCaprio', 'M');
INSERT INTO tbl_actor VALUES (56, 'Morgan Freeman', 'M');

-- Shows (FIXED IDs)
INSERT INTO tbl_show VALUES (300,200,501,TO_TIMESTAMP('2024-05-09 18:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2024-05-09','YYYY-MM-DD'),100,'English');
INSERT INTO tbl_show VALUES (301,201,502,TO_TIMESTAMP('2024-05-10 19:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2024-05-10','YYYY-MM-DD'),150,'English');
INSERT INTO tbl_show VALUES (302,202,503,TO_TIMESTAMP('2024-05-11 20:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2024-05-11','YYYY-MM-DD'),120,'English');
INSERT INTO tbl_show VALUES (303,203,504,TO_TIMESTAMP('2024-05-12 21:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2024-05-12','YYYY-MM-DD'),80,'English');
INSERT INTO tbl_show VALUES (304,204,505,TO_TIMESTAMP('2024-05-13 22:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2024-05-13','YYYY-MM-DD'),90,'English');

-- Tickets
INSERT INTO tbl_tickets VALUES (100, 1, 300, 2);
INSERT INTO tbl_tickets VALUES (101, 2, 301, 1);
INSERT INTO tbl_tickets VALUES (102, 3, 302, 3);
INSERT INTO tbl_tickets VALUES (103, 4, 303, 2);
INSERT INTO tbl_tickets VALUES (104, 5, 304, 4);

-- Movie Actors
INSERT INTO tbl_movie_actor VALUES (501,51);
INSERT INTO tbl_movie_actor VALUES (501,56);
INSERT INTO tbl_movie_actor VALUES (505,56);
INSERT INTO tbl_movie_actor VALUES (502,52);
INSERT INTO tbl_movie_actor VALUES (503,53);
INSERT INTO tbl_movie_actor VALUES (504,54);
INSERT INTO tbl_movie_actor VALUES (505,55);

-- Feedback
INSERT INTO tbl_feedback VALUES (1,'Great movie!',501,1);
INSERT INTO tbl_feedback VALUES (2,'Superb acting!',502,2);
INSERT INTO tbl_feedback VALUES (3,'Amazing cinematography!',505,5);

COMMIT;

------------------------------------------------------
-- 4. FUNCTIONS + PROCEDURES (CREATE OR REPLACE ... /)
-- Each block ends with a "/" on a new line (required by SQL*Plus / Oracle web consoles)
------------------------------------------------------

-- LOGIN FUNCTION
CREATE OR REPLACE FUNCTION login(p_username IN VARCHAR2, p_password IN VARCHAR2)
RETURN NUMBER AS
  v_pass VARCHAR2(256);
  v_id NUMBER;
BEGIN
  SELECT password, customer_id INTO v_pass, v_id
  FROM tbl_customer
  WHERE username = p_username;

  IF v_pass = p_password THEN
    RETURN v_id;
  ELSE
    RETURN -2;
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN RETURN -1;
END;
/
-- (If you prefer hashed passwords in future, replace plain comparison with hash check)

-- CREATE ACCOUNT FUNCTION
CREATE OR REPLACE FUNCTION create_account(
    p_username VARCHAR2,
    p_password VARCHAR2,
    p_customer_name VARCHAR2,
    p_phone VARCHAR2,
    p_dob DATE,
    p_email VARCHAR2
) RETURN NUMBER AS
  v_new_id NUMBER;
BEGIN
  SELECT NVL(MAX(customer_id),0)+1 INTO v_new_id FROM tbl_customer;

  INSERT INTO tbl_customer (customer_id, customer_name, phone_number, dob, email, username, password)
  VALUES (v_new_id, p_customer_name, p_phone, p_dob, p_email, p_username, p_password);

  COMMIT;
  RETURN v_new_id;

EXCEPTION 
  WHEN DUP_VAL_ON_INDEX THEN
    RETURN -1;
END;
/

-- SHOW MOVIES
CREATE OR REPLACE PROCEDURE show_films(p_flag NUMBER) AS
BEGIN
  IF p_flag = 0 THEN DBMS_OUTPUT.PUT_LINE('Login required'); RETURN; END IF;

  FOR m IN (SELECT * FROM tbl_movie ORDER BY movie_id) LOOP
    DBMS_OUTPUT.PUT_LINE(m.movie_id||' - '||m.movie_name);
  END LOOP;
END;
/

-- SEARCH MOVIE
CREATE OR REPLACE PROCEDURE search_movie(p_title VARCHAR2,p_flag NUMBER) AS
  v_found NUMBER:=0;
BEGIN
  IF p_flag = 0 THEN DBMS_OUTPUT.PUT_LINE('Login required'); RETURN; END IF;

  FOR m IN (SELECT * FROM tbl_movie WHERE UPPER(movie_name) LIKE '%'||UPPER(p_title)||'%' ORDER BY movie_id) LOOP
    DBMS_OUTPUT.PUT_LINE(m.movie_id||' - '||m.movie_name);
    v_found:=1;
  END LOOP;

  IF v_found=0 THEN DBMS_OUTPUT.PUT_LINE('Movie not found'); END IF;
END;
/

-- SHOW TIMINGS
CREATE OR REPLACE PROCEDURE show_dates_timings(p_movie NUMBER,p_flag NUMBER) AS
  v_found NUMBER := 0;
BEGIN
  IF p_flag = 0 THEN DBMS_OUTPUT.PUT_LINE('Login required'); RETURN; END IF;

  FOR s IN (SELECT * FROM tbl_show WHERE movie_id=p_movie ORDER BY show_date, show_time) LOOP
    DBMS_OUTPUT.PUT_LINE('Show ID: '||s.show_id||' | Date: '||TO_CHAR(s.show_date,'YYYY-MM-DD')||' | Time: '||TO_CHAR(s.show_time,'HH24:MI'));
    v_found := 1;
  END LOOP;

  IF v_found = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No shows found for that movie.');
  END IF;
END;
/

-- SHOW FEEDBACK
CREATE OR REPLACE PROCEDURE show_feedbacks(p_movie NUMBER,p_flag NUMBER) AS
  v_found NUMBER := 0;
BEGIN
  IF p_flag = 0 THEN DBMS_OUTPUT.PUT_LINE('Login required'); RETURN; END IF;

  FOR f IN (SELECT feedback, customer_id FROM tbl_feedback WHERE movie_id=p_movie) LOOP
    DBMS_OUTPUT.PUT_LINE('By Customer ID '||f.customer_id||': '||f.feedback);
    v_found := 1;
  END LOOP;

  IF v_found = 0 THEN DBMS_OUTPUT.PUT_LINE('No feedback for this movie.'); END IF;
END;
/

-- BOOK TICKET
CREATE OR REPLACE PROCEDURE book_ticket(
  p_cust NUMBER,
  p_show NUMBER,
  p_seats NUMBER,
  p_flag NUMBER
) AS
  v_left NUMBER;
  v_new NUMBER;
BEGIN
  IF p_flag = 0 THEN DBMS_OUTPUT.PUT_LINE('Login required'); RETURN; END IF;

  SELECT seats_left INTO v_left FROM tbl_show WHERE show_id=p_show FOR UPDATE;

  IF v_left IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Show not found.');
    RETURN;
  END IF;

  IF v_left < p_seats THEN
    DBMS_OUTPUT.PUT_LINE('Not enough seats! Available='||v_left);
    RETURN;
  END IF;

  SELECT NVL(MAX(ticket_id),0)+1 INTO v_new FROM tbl_tickets;

  INSERT INTO tbl_tickets (ticket_id, customer_id, show_id, noOfSeats)
  VALUES (v_new, p_cust, p_show, p_seats);

  UPDATE tbl_show SET seats_left = seats_left - p_seats WHERE show_id = p_show;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Ticket booked, ID='||v_new);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Show not found.');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error booking ticket: '||SQLERRM);
END;
/

-- CANCEL TICKET
CREATE OR REPLACE PROCEDURE cancel_ticket(
  p_user NUMBER,
  p_ticket NUMBER,
  p_flag NUMBER
) AS
  v_c NUMBER; v_s NUMBER; v_n NUMBER;
BEGIN
  IF p_flag = 0 THEN DBMS_OUTPUT.PUT_LINE('Login required'); RETURN; END IF;

  SELECT customer_id, show_id, noOfSeats INTO v_c, v_s, v_n
  FROM tbl_tickets WHERE ticket_id = p_ticket;

  IF v_c<>p_user THEN
    DBMS_OUTPUT.PUT_LINE('Cannot cancel someone else''s ticket!');
    RETURN;
  END IF;

  DELETE FROM tbl_tickets WHERE ticket_id = p_ticket;
  UPDATE tbl_show SET seats_left = seats_left + v_n WHERE show_id = v_s;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Ticket cancelled.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Ticket ID not found.');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error cancelling ticket: '||SQLERRM);
END;
/
------------------------------------------------------
-- GET ACTORS FOR MOVIE
------------------------------------------------------
CREATE OR REPLACE PROCEDURE get_actors_for_movie(p_movie_id NUMBER) AS
  v_found NUMBER := 0;
BEGIN
    FOR a IN (
        SELECT ac.actor_name
        FROM tbl_movie_actor ma
        JOIN tbl_actor ac ON ma.actor_id = ac.actor_id
        WHERE ma.movie_id = p_movie_id
        ORDER BY ac.actor_name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Actor: ' || a.actor_name);
        v_found := 1;
    END LOOP;

    IF v_found = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No actors found for this movie.');
    END IF;
END;
/

------------------------------------------------------
-- PRINT TICKET DETAILS
------------------------------------------------------
CREATE OR REPLACE PROCEDURE print_ticket_details(p_ticket_id NUMBER) AS
    v_show_time TIMESTAMP;
    v_show_date DATE;
    v_theatre_address VARCHAR2(255);
    v_movie_name VARCHAR2(100);
    v_customer_name VARCHAR2(64);
BEGIN
    SELECT s.show_time, s.show_date, t.address, m.movie_name, c.customer_name
    INTO v_show_time, v_show_date, v_theatre_address, v_movie_name, v_customer_name
    FROM tbl_tickets tk
    JOIN tbl_show s ON tk.show_id = s.show_id
    JOIN tbl_theatre t ON s.theatre_id = t.theatre_id
    JOIN tbl_movie m ON s.movie_id = m.movie_id
    JOIN tbl_customer c ON tk.customer_id = c.customer_id
    WHERE tk.ticket_id = p_ticket_id;

    DBMS_OUTPUT.PUT_LINE('Ticket ID: ' || p_ticket_id);
    DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer_name);
    DBMS_OUTPUT.PUT_LINE('Movie: ' || v_movie_name);
    DBMS_OUTPUT.PUT_LINE('Show Date: ' || TO_CHAR(v_show_date,'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Show Time: ' || TO_CHAR(v_show_time,'HH24:MI'));
    DBMS_OUTPUT.PUT_LINE('Theatre Address: ' || v_theatre_address);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Ticket ID not found.');
END;
/

------------------------------------------------------
-- SHOW ALL BOOKINGS FOR A CUSTOMER
------------------------------------------------------
CREATE OR REPLACE PROCEDURE show_bookings_for_customer(p_customer_id NUMBER) AS
  v_found NUMBER := 0;
BEGIN
    FOR b IN (
        SELECT m.movie_name, s.show_date, s.show_time, t.address, tk.ticket_id, tk.noOfSeats
        FROM tbl_tickets tk
        JOIN tbl_show s ON tk.show_id = s.show_id
        JOIN tbl_movie m ON s.movie_id = m.movie_id
        JOIN tbl_theatre t ON s.theatre_id = t.theatre_id
        WHERE tk.customer_id = p_customer_id
        ORDER BY s.show_date, s.show_time
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Ticket ID: ' || b.ticket_id);
        DBMS_OUTPUT.PUT_LINE('Movie: ' || b.movie_name);
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(b.show_date,'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('Time: ' || TO_CHAR(b.show_time,'HH24:MI'));
        DBMS_OUTPUT.PUT_LINE('Seats: ' || b.noOfSeats);
        DBMS_OUTPUT.PUT_LINE('Theatre: ' || b.address);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
        v_found := 1;
    END LOOP;

    IF v_found = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No bookings found for this customer.');
    END IF;
END;
/

COMMIT;

------------------------------------------------------
-- RUN MANUALLY: Example anonymous PL/SQL blocks to test (execute each block separately)
-- Copy one block, paste it into the editor, and run it. Do NOT run them all at once.
------------------------------------------------------

-- Test login: returns customer_id, -1 (no user) or -2 (bad password)
-- BEGIN
--   DECLARE
--     v_ret NUMBER;
--   BEGIN
--     v_ret := login('johndoe', 'password123');
--     DBMS_OUTPUT.PUT_LINE('login returned: ' || v_ret);
--   END;
-- END;
-- /

-- Show films (requires flag=1 to act as 'logged in')
-- BEGIN
--   show_films(1);
-- END;
-- /

-- Search movie (case-insensitive)
-- BEGIN
--   search_movie('Inception', 1);
-- END;
-- /

-- Show dates & timings for a movie (movie_id 505)
-- BEGIN
--   show_dates_timings(505, 1);
-- END;
-- /

-- Book ticket (customer 1 books 2 seats for show 300)
-- BEGIN
--   book_ticket(1, 300, 2, 1);
-- END;
-- /

-- Cancel ticket (customer 1 cancels ticket 100)
-- BEGIN
--   cancel_ticket(1, 100, 1);
-- END;
-- /

-- Get actors for a movie
-- BEGIN
--   get_actors_for_movie(501);
-- END;
-- /

-- Print ticket details
-- BEGIN
--   print_ticket_details(100);
-- END;
-- /

-- Show bookings for customer 1
-- BEGIN
--   show_bookings_for_customer(1);
-- END;
-- /

------------------------------------------------------
-- End of file
------------------------------------------------------