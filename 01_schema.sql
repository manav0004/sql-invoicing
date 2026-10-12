-- STEP 1: the 4 tables. (Written by Claude on request. Read the REFERENCES lines before moving on.)
-- Run:  node run.js 01_schema.sql    (start over with: node run.js --reset)
-- Check it worked:  SELECT name FROM sqlite_master WHERE type = 'table';
--
-- The chain: customers <- orders <- invoices <- payments
-- Each arrow is a FOREIGN KEY: the child row stores the parent's id.

CREATE TABLE customers (
  id          INTEGER PRIMARY KEY,
  name        TEXT NOT NULL,
  email       TEXT NOT NULL UNIQUE,
  city        TEXT,
  signup_date TEXT NOT NULL
);

CREATE TABLE orders (
  id          INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers(id),
  order_date  TEXT NOT NULL,
  total       REAL NOT NULL CHECK (total >= 0)
);

CREATE TABLE invoices (
  id         INTEGER PRIMARY KEY,
  order_id   INTEGER NOT NULL UNIQUE REFERENCES orders(id),
  issue_date TEXT NOT NULL,
  due_date   TEXT NOT NULL,
  amount     REAL NOT NULL CHECK (amount >= 0),
  CHECK (due_date >= issue_date)
);

CREATE TABLE payments (
  id         INTEGER PRIMARY KEY,
  invoice_id INTEGER NOT NULL REFERENCES invoices(id),
  paid_date  TEXT NOT NULL,
  amount     REAL NOT NULL CHECK (amount > 0)
);

SELECT name FROM sqlite_master WHERE type = 'table';
