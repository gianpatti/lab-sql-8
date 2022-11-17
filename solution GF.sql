use sakila;
-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select * from film;

select title, length, dense_rank() over (order by length desc) from film
where length is not null and length!=0;

-- 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.  

select title, length, rating, dense_rank() over (partition by rating order by length desc) from film
where length is not null and length!=0;

-- 3. How many films are there for each of the categories in the category table? **Hint**: Use appropriate join between the tables "category" and "film_category".

select name, count(name) as number_of_films from sakila.category a
join sakila.film_category l using (category_id)
group by name;

-- 4. Which actor has appeared in the most films? **Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select first_name, last_name, count(film_id) from actor a
join film_actor l using (actor_id)
group by actor_id, first_name, last_name
order by count(film_id) desc;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.

select first_name, last_name, count(rental_id) from customer a
join rental l using (customer_id)
group by customer_id, first_name, last_name
order by count(rental_id) desc;

-- **Bonus**: Which is the most rented film? (The answer is Bucket Brotherhood).

select title, count(rental_id) from rental a
join inventory l using (inventory_id)
join film using (film_id)
group by film_id, title
order by count(rental_id) desc;