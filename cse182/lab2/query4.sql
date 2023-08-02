-- Each office holder was elected to an elected office in an election; an election is identified by (officeID, 
-- electionDate).  An office holder has a high rating if the rating for that office holder is either ‘A’ or ‘’B’ (with 
-- that capitalization).
--
-- Write a SQL query which finds the office holders for whom all of the following are true: 
--      The office holder has a high rating. 
--      The salary for  that office holder’s elected office is more than 125 thousand (125000). 
--      The occupation for the person holding that office isn’t NULL. 
--      The occupation for the person holding that office isn’t NULL. 
--
-- The attributes which should appear in your result are the office holder’s personName, rating, salary, 
-- occupation, and officeName. 
--
-- No duplicates should appear in your result. 

SELECT DISTINCT p.personName, oh.rating, eo.salary, p.occupation, eo.officeName
FROM OfficeHolders oh, ElectedOffices eo, Persons p 
WHERE p.personID = oh.candidateID AND (oh.rating = 'A' OR oh.rating = 'B') AND (eo.salary > 125000) AND (eo.officeID = oh.officeID) AND (p.occupation IS NOT NULL);