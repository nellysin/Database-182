-- A person has been a candidate for office if there is a tuple in the CandidatesForOffice table for that 
-- person.  A person has been an office holder if there is a tuple in the OfficeHolders table for that person. 
--
-- Write a SQL query which finds the personID and occupation for persons who have been candidates for
-- office but who have not been office holders.
--
-- No duplicates should appear in your result. 

SELECT p.personID, p.occupation
FROM Persons P
WHERE p.personID IN ( 
    SELECT cfo.candidateID
    FROM CandidatesForOffice cfo
) AND p.personID NOT IN (
        SELECT oh.candidateID
        FROM OfficeHolders oh
);