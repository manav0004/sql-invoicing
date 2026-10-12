-- STEP 2: INSERT 5-10 rows per table. Include these messy cases on purpose:
--   [ ] a customer with no orders
--   [ ] an order with no invoice yet
--   [ ] an invoice that's fully paid
--   [ ] an invoice with a partial payment
--   [ ] an invoice with no payment at all, due date already passed
--   [ ] customers in at least 3 different cities
--   [ ] payments in at least 2 different months
-- Then try inserting an order for a customer id that doesn't exist.
-- If foreign keys work, you'll get an error. That's the point.

 INSERT INTO customers (id, name, email, city, signup_date) VALUES 
 (1,'Jana Hernandez', 'janah@mail.com', 'Sabadell', '2026-05-23'), 
 (2,'Marc Justo','marc@mail.com', 'Barcelona', '2026-06-01'),
 (3, 'Rosa Perez','rosa@mail.com', 'Castellar', '2026-08-29'),
 (4,'Joan March', 'joan@mail.com', 'Sabadell', '2026-07-19'), 
 (5, 'Pilar Ruiz', 'pilar@mail.com', 'Barcelona', '2026-10-09');

 INSERT INTO orders (id, customer_id, order_date, total) VALUES
 (1,1,'2026-08-31',45.00),
 (2,1,'2026-09-04',120.50),
 (3,2,'2026-09-15',89.99),
 (4,3,'2026-09-22',300.00),
 (5,4,'2026-10-01',15.75),
 (6,3,'2026-10-07',210.00);
 
 INSERT INTO invoices ( order_id, issue_date, due_date, amount) 
 SELECT id, order_date, date(order_date, '+30 days'), total
 FROM orders
 WHERE id  <= 5;

 INSERT INTO payments (invoice_id, paid_date, amount) VALUES
 (1, '2026-09-20', 45.00),
 (3, '2026-10-05', 40.00),
 (4, '2026-09-30', 150.00),
 (4, '2026-10-10', 150.00);

INSERT INTO orders (customer_id, order_date, total) VALUES (99, '2026-10-01', 50.00);