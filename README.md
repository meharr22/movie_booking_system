# Movie Booking System (Oracle SQL / PL-SQL Project)

## Overview
This project is a **Movie Booking System** implemented using **Oracle SQL and PL/SQL**. It simulates a real-world cinema booking platform where users can browse movies, book tickets, cancel bookings, and view show details.

The system includes **database design, relationships, stored procedures, and functions**, making it a complete DBMS-based project.



## Features
-  User Login & Account Creation
-  View Available Movies
-  Search Movies (case-insensitive)
-  View Show Dates & Timings
-  Book Tickets
-  Cancel Tickets
-  View Booking Details
-  Feedback System
-  View Actors for a Movie


##  Database Design

### Tables Used
- `tbl_customer` → Stores user details  
- `tbl_movie` → Movie information  
- `tbl_theatre` → Theatre details  
- `tbl_show` → Show timings & seat availability  
- `tbl_tickets` → Ticket bookings  
- `tbl_feedback` → User feedback  
- `tbl_actor` → Actor details  
- `tbl_movie_actor` → Many-to-many relationship  



##  Functional Modules

###  Functions
- `login()` → Authenticates user  
- `create_account()` → Registers new user  

###  Procedures
- `show_films()` → Display all movies  
- `search_movie()` → Search by title  
- `show_dates_timings()` → Show schedules  
- `book_ticket()` → Book tickets  
- `cancel_ticket()` → Cancel booking  
- `show_feedbacks()` → View reviews  
- `get_actors_for_movie()` → List actors  
- `print_ticket_details()` → Ticket info  
- `show_bookings_for_customer()` → Booking history  



##  Sample Data
The system includes pre-inserted data for:
- Customers  
- Movies (e.g., Inception, The Dark Knight)  
- Shows  
- Tickets  
- Actors  


##  How to Run

1. Open an Oracle SQL environment (like SQL*Plus / freesql.org)
2. Copy and paste the SQL file
3. Run the script to:
   - Create tables
   - Insert data
   - Create procedures & functions



##  Testing
Example test blocks are included in the file (commented).  
Uncomment and run them one at a time to test functionality.



##  Technologies Used
- Oracle SQL  
- PL/SQL  
- Relational Database Design  



##  Learning Outcomes
- Database schema design  
- Primary & foreign key relationships  
- PL/SQL procedures & functions  
- Transaction handling (COMMIT / ROLLBACK)  
- Real-world system simulation  



##  Future Improvements
- Web-based frontend (React / HTML)  
- Payment integration  
- Seat selection UI  
- Admin dashboard  



##  Author
**Mehar Arora**  
  
