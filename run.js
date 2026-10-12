// Runs a .sql file against invoicing.db and prints any SELECT results as tables.
// Usage:  node run.js 01_schema.sql      |   node run.js --reset   (deletes the database)
const fs = require('node:fs');
const { DatabaseSync } = require('node:sqlite');

const DB = 'invoicing.db';
const arg = process.argv[2];

if (arg === '--reset') {
  fs.rmSync(DB, { force: true });
  console.log('invoicing.db deleted. Run 01_schema.sql again.');
  process.exit(0);
}
if (!arg) {
  console.log('Usage: node run.js <file.sql>   or   node run.js --reset');
  process.exit(1);
}

const db = new DatabaseSync(DB);
db.exec('PRAGMA foreign_keys = ON;');

const statements = fs.readFileSync(arg, 'utf8')
  .split('\n').filter(l => !l.trim().startsWith('--')).join('\n')
  .split(';').map(s => s.trim()).filter(Boolean);

if (statements.length === 0) console.log(`${arg} has no SQL yet. Write some!`);

statements.forEach((sql, i) => {
  try {
    if (/^(select|with|pragma)/i.test(sql)) {
      const rows = db.prepare(sql).all();
      console.log(`\n#${i + 1}: ${rows.length} row(s)`);
      rows.length ? console.table(rows) : console.log('(no rows)');
    } else {
      db.exec(sql);
      console.log(`#${i + 1}: ok  (${sql.split('\n')[0].slice(0, 60)})`);
    }
  } catch (e) {
    console.log(`\n#${i + 1}: ERROR  ${e.message}\n${sql}\n`);
  }
});
