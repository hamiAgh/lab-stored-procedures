# 1.Write queries, stored procedures to answer the following questions:
# In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. 
# Convert the query into a simple stored procedure. Use the following query:

  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
  use sakila;


delimiter //
create procedure action_movie_lovers ()
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end;
//
delimiter ;

call action_movie_lovers;


#2.

drop procedure if exists action_movie_lovers_automation;

delimiter //
create procedure action_movie_lovers_automation (in cat char(20))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = cat
  group by first_name, last_name, email;
end
//
delimiter ;

call action_movie_lovers_automation("Action");

#3.Write a query to check the number of movies released in each movie category. 
#Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 
#Pass that number as an argument in the stored procedure.

SELECT COUNT(DISTINCT f.film_id) AS movie_number, c.name FROM sakila.film f
JOIN sakila.film_category fc
USING (film_id)
JOIN sakila.category c 
USING (category_id)
GROUP BY c.name;


delimiter //
create procedure movie_category (IN param INT)
begin
  SELECT COUNT(DISTINCT f.film_id) AS movie_number, c.name FROM sakila.film f
JOIN sakila.film_category fc
USING (film_id)
JOIN sakila.category c 
USING (category_id)
GROUP BY c.name
HAVING movie_number >= param;
end
//
delimiter ;

call movie_category (58);