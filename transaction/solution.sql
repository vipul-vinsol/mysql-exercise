UPDATE accounts  SET balance = balance + 1000 WHERE acc_no = (SELECT acc_no FROM users WHERE name='userA');

UPDATE accounts  SET balance = balance - 500 WHERE acc_no = (SELECT acc_no FROM users WHERE name='userA');

begin;

UPDATE accounts  SET balance = balance - 200 WHERE acc_no = (SELECT acc_no FROM users WHERE name='userA');

UPDATE accounts  SET balance = balance + 200 WHERE acc_no = (SELECT acc_no FROM users WHERE name='userB');

commit;
