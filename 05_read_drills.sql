-- STEP 5: reading drills. This is the "read a query" half of the test,
-- and what support work looks like: someone else's query, and you work out what it does.
--
-- For each one, BEFORE running anything:
--   1. Write your prediction as a comment under it (rows, numbers, or the bug).
--   2. THEN run:  node run.js 05_read_drills.sql
--   3. Were you right? If not, say why in one line.
-- Some of these run without any error and still give a wrong answer. Those are the dangerous ones.


-- ============ WEDNESDAY 14 ============

-- R1. Predict: how many rows, and which names?
SELECT customers.name, orders.id
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id
WHERE orders.id IS NULL;

-- R2. Someone wanted the number of customers per city. Predict what this prints, and find the bug.
SELECT customers.city, COUNT(*) AS people
FROM customers;
GROUP BY customers.city;


-- ============ THURSDAY 15 ============

-- R3. Wanted: customers who spent more than 200. Find the bug without running it.
SELECT customers.name, SUM(orders.total) AS spent
FROM customers
JOIN orders ON orders.customer_id = customers.id
WHERE SUM(orders.total) > 200
GROUP BY customers.id;

-- R4. Wanted: the orders of customers from Terrassa. It runs with no error.
--     How many rows SHOULD it return? How many does it return? Why?
SELECT customers.name, orders.id, orders.total
FROM customers
JOIN orders ON orders.customer_id
WHERE customers.city = 'Terrassa';


-- ============ FRIDAY 16 ============

-- R5. Wanted: every invoice that still has money owed. It runs with no error.
--     Which invoices are missing from the result, and why?
SELECT invoices.id, invoices.amount - SUM(payments.amount) AS owed
FROM invoices
LEFT JOIN payments ON payments.invoice_id = invoices.id
GROUP BY invoices.id
HAVING owed > 0;

-- R6. Wanted: invoiced and paid per customer. It runs with no error.
--     Which customers' "invoiced" number is wrong, and why? (Think about Q10.)
SELECT customers.name, SUM(invoices.amount) AS invoiced, SUM(payments.amount) AS paid
FROM customers
JOIN orders ON orders.customer_id = customers.id
JOIN invoices ON invoices.order_id = orders.id
LEFT JOIN payments ON payments.invoice_id = invoices.id
GROUP BY customers.id;
