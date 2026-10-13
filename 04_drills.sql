-- STEP 4: drills. New questions on the same data, NOT the old 10.
-- Run:  node run.js 04_drills.sql      (say "check" when you want feedback)
--
-- Every session:
--   1. Warm-up (5 min): write the clause order from memory in a comment, then check it.
--   2. Before each query, write ONE comment line naming the pattern, e.g.
--        -- pattern: never -> LEFT JOIN + IS NULL
--      Naming the pattern first is the actual training. The SQL comes after.
--   3. Stuck? Look at PATTERNS.md or ask. Looking things up is allowed here.


-- ============ WEDNESDAY 14: set A, joins and "never" ============

-- A1. List every order with the customer's name and city, newest order first.

-- A2. Which orders were placed by customers from Terrassa? Show the name, order id and total.

-- A3. Which customers have an order that hasn't been invoiced yet? Show the name and the order id.

-- A4 (stretch). Which invoices have never received a payment? Show the invoice id, customer name and amount.


-- ============ THURSDAY 15: set B, per-X / HAVING / top N ============

-- B1. How many orders has each customer placed? Customers with zero orders must show 0.

-- B2. Which cities have more than 2 customers?

-- B3. What are the 3 biggest single orders, and who placed them?


-- ============ THURSDAY 15: inconsistency hunt ============
-- At least 3 problems are hidden in the data. Find them with queries, then
-- write one plain sentence under each saying what's wrong and how you'd
-- explain it to a customer or a teammate.

-- I1. Is any customer in the table twice? (Hint: the same person can sign up
--     with a slightly different email. Why didn't UNIQUE stop it?)

-- I2 (stretch). Is there an invoice whose amount doesn't match its order's total?

-- I3 (stretch). Is there an invoice that was paid MORE than its amount? By how much?


-- ============ FRIDAY 16: set C, "might have nothing", dates, CTE ============

-- C1. For every invoice, how much has been paid so far? Unpaid invoices must show 0.

-- C2. How many payments came in per month, and what was the total each month?

-- C3. What does each city still owe in total? (Two levels again, like Q10:
--     owed per invoice first, then add those up per city.)
