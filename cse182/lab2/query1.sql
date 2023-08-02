--A person is a felon if the value of the isFelon attribute in Persons is TRUE
--
-- Write a SQL query which finds the elections in which at least one of the candidates for office in that 
-- election is a felon.  The attributes in your result should be officeID, electionDate, officeStartDate and 
-- officeEndDate, which should appear in your result as theOfficeID, theElectionDate, theOfficeStartDate and 
-- theOfficeEndDate. 
-- 
-- No duplicates should appear in your result. 

SELECT DISTINCT e.officeID AS theOfficeID, e.electionDate AS theElectionDate, e.officeStartDate AS theOfficeStartDate, e.officeEndDate AS theOfficeEndDate
FROM Elections e, CandidatesForOffice cfo, Persons p
WHERE e.officeID = cfo.officeID AND e.electionDate = cfo.electionDate AND cfo.candidateID = p.personID AND p.isFelon = TRUE;