-- STEP 2b: more rows so the drills have variety. Written by Claude (tedious data).
-- Rebuild order:  node run.js --reset  ->  01_schema.sql  ->  02_seed.sql  ->  02b_more_data.sql
--
-- Some rows are wrong ON PURPOSE. Real support data is messy, and finding the
-- problems is part of the drills. Don't read the notes at the bottom until
-- Thursday's inconsistency hunt.

INSERT INTO customers (id, name, email, city, signup_date) VALUES
 (6,  'Laia Puig',   'laia@mail.com',  'Terrassa',  '2026-04-11'),
 (7,  'Joan March',  'Joan@mail.com',  'Sabadell',  '2026-09-02'),
 (8,  'Oriol Vidal', 'oriol@mail.com', 'Terrassa',  '2026-06-15'),
 (9,  'Nuria Soler', 'nuria@mail.com', NULL,        '2026-07-30'),
 (10, 'Pau Ferrer',  'pau@mail.com',   'Barcelona', '2026-09-18'),
 (11, 'Marta Roca',  'marta@mail.com', 'Castellar', '2026-10-02');

INSERT INTO orders (id, customer_id, order_date, total) VALUES
 (7,  6,  '2026-08-05', 520.00),
 (8,  6,  '2026-09-12', 75.25),
 (9,  7,  '2026-09-25', 30.00),
 (10, 8,  '2026-08-20', 199.99),
 (11, 9,  '2026-09-08', 60.00),
 (12, 10, '2026-09-28', 410.00),
 (13, 10, '2026-10-06', 95.50),
 (14, 8,  '2026-10-11', 22.40);

INSERT INTO invoices (id, order_id, issue_date, due_date, amount) VALUES
 (6,  7,  '2026-08-05', '2026-09-04', 520.00),
 (7,  8,  '2026-09-12', '2026-10-12', 75.25),
 (8,  9,  '2026-09-25', '2026-10-25', 30.00),
 (9,  10, '2026-08-20', '2026-09-19', 219.99),
 (10, 11, '2026-09-08', '2026-10-08', 60.00),
 (11, 12, '2026-09-28', '2026-10-28', 410.00),
 (12, 13, '2026-10-06', '2026-11-05', 95.50);

INSERT INTO payments (invoice_id, paid_date, amount) VALUES
 (6,  '2026-08-28', 200.00),
 (6,  '2026-09-15', 200.00),
 (6,  '2026-10-03', 120.00),
 (7,  '2026-10-01', 75.25),
 (9,  '2026-09-10', 100.00),
 (10, '2026-09-20', 50.00),
 (10, '2026-09-21', 50.00),
 (11, '2026-10-09', 410.00),
 (12, '2026-10-12', 45.50);

-- What's in here (spoilers for Thursday):
--   customers 5 and 11 have no orders
--   orders 6 and 14 have no invoice
--   3 planted problems: a duplicate customer, an invoice that doesn't match
--   its order, and an invoice that was paid too much
