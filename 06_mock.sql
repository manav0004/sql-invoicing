-- STEP 6: SATURDAY 17 mock test. 40 minutes, timer on.
-- Same notes rule as the real test (if you don't know it yet, do it without notes).
-- No "check" until the time is up. Then we go through every mistake together.
-- Run:  node run.js 06_mock.sql


-- WRITE (4 questions)

-- M1. Which customers have no invoice at all, not even one?
--     (Careful: a customer with one invoiced order and one uninvoiced order DOES have an invoice.)

-- M2. How much has been invoiced per city, highest first?

-- M3. Which customers placed more than one order? Show the name and how many orders.

-- M4. Pretend today is 2026-10-15. Which invoices are overdue (past due, not fully paid),
--     and by how many days?


-- READ (2 questions): write your answer as a comment, don't run them first

-- M5. What number does this show for Pilar Ruiz (no orders)? Is that right? How would you fix it?
SELECT customers.name, COUNT(*) AS orders_placed
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id
GROUP BY customers.id;

-- M6. Find the bug without running it.
SELECT strftime('%Y-%m', paid_date) AS month, SUM(amount) AS total
FROM payments
ORDER BY month
GROUP BY month;
