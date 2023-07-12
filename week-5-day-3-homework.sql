--1. List all customers who live in Texas (use JOINs)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, a.district
FROM customer c 
	JOIN address a 
	ON c.address_id = a.address_id 
WHERE a.district = 'California';
--ANSWER: 9 customers live in California (Patricia Johnson, Betty White, Alice Stewart, 
-->                  					  Rosa Reynolds, Renee Lane, Kristin Johnston,
-->                                       Cassandra Walters, Jacob Lance, Rene Mcalister)



--2. Get all payments above $6.99 with the Customer's full name
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, p.amount
FROM customer c 
	JOIN payment p  
	ON c.customer_id  = p.customer_id  
WHERE p.amount > 6.99;
--> ANSWER: returns 1406 names whose payment amount ranges from 7.98-11.99.



--3. Show all customers names who have made payments over $175 (use subqueries)
-->customer names(payments > 175)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM customer c 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment p 
	GROUP BY customer_id 
	HAVING SUM(p.amount) > 175
);
-->ANSWER: 6 names: Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Tommy Collazo, and Karl Seal



--4. List all customers that live in Nepal (use city table)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id 
	JOIN city c2 
	ON a.city_id = c2.city_id 
		JOIN country c3 
		ON c2.country_id = c3.country_id 
		WHERE c3.country = 'Nepal';
--> ANSWER: Kevin Schuler is the only customer living in Nepal.




--5. Which staff member had the most transactions?
SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name, COUNT(p.rental_id)
FROM staff s 
	JOIN payment p 
	ON s.staff_id = p.staff_id 
GROUP BY first_name, last_name
ORDER BY COUNT(p.rental_id) DESC 
LIMIT 1;
-->ANSWER: Jon Stephens handled the most transactions at 7,304




--6. How many movies of each rating are there?
SELECT rating, COUNT(*) AS count
FROM film
GROUP BY rating;
--> G: 178, PG: 194, PG-13: 223, R: 195, NC-17: 210




--7. Show all customers who have made a single payment above $6.99 (use subqueries)
SELECT DISTINCT CONCAT(first_name, ' ', last_name)AS full_name
FROM customer c 
WHERE customer_id IN (
	SELECT p.customer_id 
	FROM payment p 
	WHERE amount > 6.99
	GROUP BY p.customer_id 
	HAVING COUNT(*) = 1
);
--> ANSWER: Returns 130 names of customers who have made only single payment above $6.99.



--8. How many free rentals did our stores give away?
SELECT s2.store_id, COUNT(p.amount) AS free_rentals
FROM payment p 
	JOIN staff s 
	ON p.staff_id = s.staff_id 
		JOIN store s2 
		ON s.store_id = s2.store_id
WHERE p.amount = 0
GROUP BY s2.store_id;
-->ANSWER: store 1 had 15 free rentals while store 2 had 9. 

--Also, I am not sure if the indentation in this is an issue. For me, it was easier to visualize and keep 
--track of. However, if I ought to avoid this, let me know and I will do so!

 



