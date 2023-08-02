--Write a file, combine.sql (which should have multiple SQL statements that are in a Serializable transaction) 
-- that will do the following.  For each tuple in ModifyElectedOffices, there might already be a tuple in the 
-- ElectedOffices table that has the same Primary Key (that is, the same value for officeID).  If there isn’t a tuple 
-- in ElectedOffices with the same Primary Key, then this is a new elected office which should be inserted into the 
-- ElectedOffices table.  If there already is a tuple in ElectedOffices with that Primary Key, then this is an update 
-- of information about that elected office.  So here are the effects that your transaction should have: 
--
--If there isn’t already a tuple in the ElectedOffices table which has that officedID, then you should insert a 
-- tuple into the ElectedOffices table corresponding to the attribute values in the ModifyElectedOffices tuple.  
-- Also, the salary for that inserted tuple should be 12345.67. 
--
--If there already is a tuple in the ElectedOffices table which has that officeID, then update the tuple in 
-- ElectedOffices which has that officeID using the officeName, city, state values which appear in the 
-- ModifyElectedOffices tuple.  Also, make the value of salary for that tuple be NULL. 
--
--Your transaction may have multiple statements in it.  The SQL constructs that we’ve already discussed in class 
-- are sufficient for you to do this part (which is one of the hardest parts of Lab3).
--

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE ElectedOffices
SET officeID = m.officeID, officeName = m.officeName, city = m.city, state = m.state, salary = NULL
FROM ModifyElectedOffices m
WHERE ElectedOffices.officeID = m.officeID;

INSERT INTO ElectedOffices(officeID, officeName, city, state, salary) 
SELECT DISTINCT m.officeID, m.officeName, m.city, m.state, 12345.67
FROM ModifyElectedOffices m
WHERE m.officeID NOT IN (
    SELECT e.officeID 
    FROM ElectedOffices e);

COMMIT TRANSACTION;
