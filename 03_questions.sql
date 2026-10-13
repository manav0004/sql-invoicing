-- STEP 3: the 10 business questions. Write one query under each.
-- Today: just 1-3. Run:  node run.js 03_questions.sql

-- Q1. Which customers have never placed an order?
SELECT  customers.name, orders.id
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id
WHERE orders.id IS NULL;
-- Q2. How much has been invoiced per customer, highest first?
SELECT customers.name, SUM(invoices.amount) AS invoiced
FROM customers
JOIN orders ON  orders.customer_id = customers.id
JOIN invoices ON invoices.order_id = orders.id
GROUP by customers.id
ORDER BY invoiced DESC;

-- Q3. Which invoices have no payment at all?
SELECT invoices.id, payments.amount  
FROM invoices
LEFT JOIN payments ON payments.invoice_id = invoices.id
WHERE payments.amount IS NULL;

-- Q4. Which invoices are partially paid, and how much is still owed on each?
SELECT invoices.id, invoices.amount, ROUND(invoices.amount - SUM(payments.amount), 2) AS owing 
FROM invoices
JOIN  payments ON payments.invoice_id = invoices.id
GROUP BY invoices.id
HAVING SUM (payments.amount) < invoices.amount;

-- Q5. How much money came in (payments) per month?
SELECT strftime('%Y-%m', paid_date) AS months, ROUND(SUM(amount), 2) AS payment
FROM payments
GROUP BY months
ORDER BY months;


-- Q6. Who are the top 3 customers by amount actually paid?
SELECT customers.name, ROUND(SUM(payments.amount), 2) AS spent
FROM customers
JOIN orders ON orders.customer_id = customers.id
JOIN invoices ON invoices.order_id = orders.id
JOIN payments ON payments.invoice_id = invoices.id
GROUP BY customers.id
ORDER BY spent DESC
LIMIT 3;


-- Q7. Which orders don't have an invoice yet?
SELECT orders.id, invoices.amount
FROM orders
LEFT JOIN invoices ON invoices.order_id = orders.id
WHERE invoices.amount IS NULL;


-- Q8. Which invoices are overdue (past due date, not fully paid), and by how many days?
SELECT invoices.id, ROUND(julianday('now') - julianday(due_date), 0) AS Passed
FROM invoices
LEFT JOIN payments ON payments.invoice_id = invoices.id
WHERE invoices.due_date < date('now')
GROUP BY invoices.id
HAVING COALESCE(SUM(payments.amount), 0) < invoices.amount;

-- Q9. What's the average order value per city?
SELECT customers.city, ROUND(AVG(orders.total), 2) AS aver
FROM customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY customers.city;



-- Q10. What does each customer still owe (invoiced minus paid)? Only show those who owe money.
WITH invoice_owned AS (
    SELECT invoices.id, invoices.order_id, invoices.amount - COALESCE (SUM(payments.amount), 0)
AS owed
    FROM invoices
    LEFT JOIN payments ON payments.invoice_id = invoices.id
    GROUP BY invoices.id
)
SELECT customers.name, ROUND(SUM(invoice_owned.owed), 2) AS owed
FROM invoice_owned
JOIN orders ON orders.id = invoice_owned.order_id
JOIN customers ON customers.id = orders.customer_id
GROUP BY customers.id
HAVING SUM(invoice_owned.owed) > 0;
