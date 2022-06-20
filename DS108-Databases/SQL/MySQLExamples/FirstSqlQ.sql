/* They would like to see all payments that had a rental amount is over .99 cents. 
However, they only want to see the rental id and payment date that is attached to that payment. */

Select rental_id , payment_date from sakila.payment where amount > .99;
/*Once you have finished that, they would like to see the staff id and customer id from the payments 
that have an amount over .99 cents.*/

SELECT staff_id, customer_id from sakila.payment where amount > .99;

Select * from sakila.film
inner join sakila.film_category
On film.film_id = film_category.film_id
where film.film_id = 1;

# write a query to find the category name and film name for each movie

select category.name as Category_Name , film.title as Film_Name from sakila.category
inner join sakila.film_category using (category_id)
inner join sakila.film using (film_id);


# for id < 20

select category.name as Category_Name , film.title as Film_Name from sakila.category
inner join sakila.film_category using (category_id)
inner join sakila.film using (film_id)
where sakila.film.film_id < 20;

# only for category name and title start with a,b,c
select category.name as Category_Name , film.title as Film_Name from sakila.category
inner join sakila.film_category using (category_id)
inner join sakila.film using (film_id)
where (film.title like "a%" OR film.title like "b%" OR film.title like "c%") 
And (category.name like "a%" OR category.name like "b%" OR category.name like "c%");

# Link the payment to the particular customer even if there's no amount present
select * from sakila.customer 
right outer join sakila.payment
using(customer_id);

#Write a query to find all rental's rental_date, return_date, amount paid for the rental, 
#and the title of each rental.

SELECT rental_date, return_date, amount, title from sakila.payment
inner join sakila.rental using(rental_id)
inner join sakila.inventory using(inventory_id)
inner join sakila.film using(film_id);

#SQLHandsOn2
#Write a query to find the first and last name, customer ID and rental ID for customers who have rented a film.
SELECT customer.customer_id, customer.first_name, customer.last_name , rental.rental_id 
FROM sakila.customer
JOIN sakila.rental USING (customer_id);

#Write a query that finds all films with actors that have an actor_id 5.
SELECT film.title FROM sakila.actor
JOIN sakila.film_actor USING(actor_id)
JOIN sakila.film USING(film_id)
WHERE sakila.actor.actor_id = 5;

#Write a query that lists out all information of every film along with the name of the language for each film, 
#even if a language doesn't exist for that film
SELECT * from sakila.film
LEFT OUTER JOIN sakila.language USING (language_id);


#Write a query that lists out the title of films and the name of the actors who starred in those films. 
#Additionally, only list films that starred artists whose first names start with a vowel.

SELECT film.title, actor.first_name, actor.last_name FROM sakila.actor
JOIN sakila.film_actor USING(actor_id)
JOIN sakila.film USING(film_id)
WHERE actor.first_name LIKE "a%" OR 
actor.first_name LIKE "e%" OR 
actor.first_name LIKE "i%" OR 
actor.first_name LIKE "o%" OR 
actor.first_name LIKE "u%" ;

/*Part 2 : You have just been hired as a Data Analyst for a company that rents films to customers.
 They would like an inventory list of films that were rented for more than $4.99.*/
 SELECT inventory.inventory_id, inventory.film_id, inventory.store_id, inventory.last_update FROM sakila.inventory
 JOIN sakila.rental USING (inventory_id)
 JOIN sakila.payment USING(rental_id)
 WHERE payment.amount > 4.99;
 
 -- -- --- - ------------------------
 # CRUD Practice
 -- -----------------------
 
 select * from sakila.actor
 where actor_id=(select max(actor_id) from sakila.actor);
 
 INSERT INTO sakila.actor(first_name, last_name)
 VALUES ("Tom", "Hanks");
 
 SELECT max(actor_id) from sakila.actor;
 
 SELECT * FROM sakila.actor
 WHERE last_name = "Hanks";
 
 SELECT * FROM sakila.address
 WHERE address2 is NULL ;
 
 UPDATE sakila.actor 
 SET first_name = "The Tom" 
 WHERE actor_id = 201;
 
 INSERT INTO sakila.actor(first_name, last_name)
 VALUES ("Penelope", "Cruz");
 
 
 SELECT * FROM sakila.actor
 WHERE actor_id >= 201;
 
 
 DELETE FROM sakila.actor
 WHERE actor_id = 202;
 
 -- LEsson3 Handon
 
/* Write a query that Inserts a new actor into the database. 
Once you have completed the insert, write a query to view all information for that specific actor. */

INSERT INTO sakila.actor (first_name, last_name)
VALUES ("Tom", "Cruise");
 
SELECT * FROM sakila.actor
WHERE first_name = "Tom";

/* Write a query to Update the actor that you just inserted. 
Give your new actor a first_name of Emmy and a last_name of Rock. 
When you have completed that update, run another query to see your updated employee. */

UPDATE sakila.actor
SET first_name = "Emmy", last_name = "Rock"
WHERE actor_id = 204;

SELECT * FROM sakila.actor
WHERE actor_id = 204;

/* Write a query that finds all staff that do not have a value specified for password. */
SELECT * FROM sakila.staff
WHERE password IS NULL;

/* Write a query that finds all staff's information that has a value for first_name and store_id. */

SELECT * FROM sakila.staff
WHERE first_name IS NOT NULL AND store_id IS NOT NULL;

/* Write a query that updates all people with a Null value in the address2 column.
 If the district is Alberta, put address2 as Canada, and if the district is QLD, put Australia.*/
 
 SELECT * FROM sakila.address WHERE address2 is NULL;
 
 UPDATE sakila.address
 SET address2 = "Canada" 
 WHERE address2 IS NULL AND district = "Alberta";
 
 UPDATE sakila.address
 SET address2 = "Australia" 
 WHERE address2 IS NULL AND district = "QLD";
 
 SELECT * FROM sakila.address WHERE district = "Alberta";
 

    
    CREATE TABLE sakila.actorExample(
    actor_id smallint(5) unsigned,
    first_name varchar(45),
    last_name varchar(45),
    last_update timestamp);
    
 INSERT INTO sakila.actorExample
VALUES(200, "Jamie", "Thomas", "2020-01-23 12:16:34");

INSERT INTO sakila.actorExample
SELECT * FROM sakila.actor LIMIT 5;


SELECT * FROM sakila.actorExample;

DROP table sakila.actorExample;

create view sakila.CurrentCustomers as
select customer_id, first_name, last_name
from sakila.customer
where active = 1;

select * from sakila.CurrentCustomers;

CREATE VIEW sakila.ActorFilms AS
SELECT first_name, last_name, film_id
FROM sakila.actor
INNER JOIN sakila.film_actor
USING(actor_id);

select * from sakila.ActorFilms;

DROP VIEW sakila.CurrentCustomers;

-- -------------------------- Lesson 4 Hands ON ----------

/*Create a view named "initialCustomers" that shows the first name, last name, and email address of customers 
that have an id of less than 100. Once that is complete, select and view your newly created view.*/

 CREATE VIEW sakila.initialCustomers AS 
 SELECT first_name, last_name, email
  FROM sakila.customer 
  WHERE customer_id < 100;
  
  SELECT * FROM sakila.initialCustomers;
  
  /* Create a table named "ProductList". Include the following columns:
ProductId, ProductName, Price, DateAdded, EmployeeSupportId.
Include the following requirements:
Every product should have an automatically generated id number that should be unique for each product.
Give each column a data type that would apply
Give the DateAdded column a default 
All columns CANNOT be null.*/

CREATE TABLE sakila.ProductList(
ProductId INTEGER PRIMARY KEY AUTO_INCREMENT, 
ProductName VARCHAR(50) NOT NULL, 
Price DECIMAL(12,3) NOT NULL, 
DateAdded DATETIME NOT NULL DEFAULT current_timestamp, 
EmployeeSupportId INTEGER NOT NULL);


/* Next, insert one product into the table following the given guidelines when the table was created.
 When inserting the data, don't include the ProductId or the DateAdded. 
Finally, run a query to see the single product in your table.*/

INSERT INTO sakila.ProductList(ProductName,Price,EmployeeSupportId)
VALUES("Camera", 500.50, 101);
INSERT INTO sakila.ProductList(ProductName,Price,EmployeeSupportId)
VALUES("Tripod", 150, 102);


SELECT * FROM sakila.ProductList;

-- ---------PRACTICE AGGREGATE GOUP BY ORDER BY

-- Find the costliest and cheapest video that was ever rented
SELECT max(amount) AS Expensive FROM payment;
SELECT min(amount) AS Affordable FROM payment;

-- total profits derived from renting videos
SELECT sum(amount) FROM payment;


-- average video rental price
SELECT avg(amount) FROM payment;

-- how many times the videos have been rented
SELECT COUNT(rental_id) FROM payment;

-- how many records are there in the table
SELECT max(payment_id) FROM payment;
-- how many differnt prices are there for the rental

SELECT COUNT(DISTINCT amount) from payment;

-- how does the price differ for diffrent film category? find average price for diffrent category.

SELECT avg(amount) AS AveragePrice, name FROM payment
INNER JOIN rental USING (rental_id)
INNER JOIN Inventory USING (inventory_id)
INNER JOIN film_category USING (film_id)
INNER JOIN Category USING (category_id)
group by name
ORDER BY AveragePrice desc;

-- maximum price by category and by state
SELECT max(amount) AS MaximumPrice, name, district FROM payment
INNER JOIN rental USING (rental_id)
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN Inventory USING (inventory_id)
INNER JOIN film_category USING (film_id)
INNER JOIN Category USING (category_id)
INNER JOIN address USING (address_id)
group by name, district
ORDER BY district, name;

-- WHUICH genre is most poplular


SELECT name, count(name) as maxfreq FROM payment
INNER JOIN rental USING (rental_id)
INNER JOIN Inventory USING (inventory_id)
INNER JOIN film_category USING (film_id)
INNER JOIN Category USING (category_id)
group by name
having maxfreq
ORDER BY maxfreq desc;

-- Which genre has most variability in pricing

SELECT name, count(distinct amount) as variability FROM payment
INNER JOIN rental USING (rental_id)
INNER JOIN Inventory USING (inventory_id)
INNER JOIN film_category USING (film_id)
INNER JOIN Category USING (category_id)
group by name
having variability
ORDER BY variability;

/* SQL Final Project */

/*Run a query that creates a table named Authors that has the following columns: AuthorID, FullName, BirthCountry.
AuthorID is the primary key and auto increments.*/

CREATE TABLE Authors(
AuthorId INTEGER PRIMARY KEY auto_increment,
FullName varchar(50),
BirthCountry varchar(50));

/* Add the following Authors table:
FullName	BirthCountry
Jane Austen	England
Charles Dickens	England
Mark Twain	United States*/

INSERT INTO Authors(FullName, BirthCountry)
VALUES("Jane Austen", "England"),("Charles Dickens", "England"),("Mark Twain","United States");

/*Run a query to see all of the authors within the database.*/

SELECT * FROM Authors;

/*Run a query that creates a table named Books that has the following columns: BookID, Name, AuthorID.
BookID is the primary key and auto increments.
AuthorID is a foreign key that referenced the Authors table on the AuthorID column.*/

CREATE TABLE Books(
BookId INTEGER PRIMARY KEY auto_increment,
Name varchar(40),
AuthorId INTEGER,
FOREIGN KEY(AuthorId) REFERENCES Authors(AuthorId)) ;

/* Add the following the Books table:
Name	AuthorID
Pride and Prejudice	1
Sense and Sensibility	1
The Pickwick Papers	2 */

INSERT INTO Books(Name, AuthorId)
VALUES("Pride and Prejudice",1),
("Sense and Sensibility",1),
("The Pickwick Papers",2);

/*Run a query to see all of the books within the database.*/ 	

SELECT * FROM Books;

/*Run a query that joins the Authors and Books table together using the AuthorID foreign key.*/

SELECT * FROM Authors
JOIN Books USING (AuthorId);


/* Next, create a view named AuthorBooks using the join query created in step 1 adding the following parameters:
Show only the Authors full name and book name.
Rename the column name results using the AS keyword.
The Authors FullName should display as AuthorName.
The Books Name should display as BookName.
Order the results alphabetically by the authors full name.*/

CREATE VIEW AuthorBooks AS
SELECT FullName AS AuthorName, Name AS BookName
FROM Authors
JOIN Books USING (AuthorId)
ORDER BY AuthorName;

/*Lastly, run a query to see the view you just created.*/

SELECT * FROM AuthorBooks;


-- ----













