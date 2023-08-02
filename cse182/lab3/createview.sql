--An election is identified by (officeID, electionDate).  A candidate for office in CandidatesForOffice ran in an election. An office holder in OfficeHolders ran in an election. 
--
--In our schema, there are several different ways that we could try to determine if a candidate for office won their 
--election … and those ways might not be consistent with each other!  We’re going to create a view which finds
--some possible inconsistencies. 
--
--  1) If the wonElection attribute for a candidate for office in an election is TRUE, then we’ll say that the 
--      candidate for office was declared the winner of their election. 
--
--  2) If a candidate for office in an election has more votes than any other candidate for office in their 
--      election, then we’ll say that the candidate for office had the most votes in their election. 
--
--We’ll say that a candidate for office was wrongly declared the winner of their election if a) the wonElection 
--attribute for that candidate for office is TRUE, but b) that candidate for office did not have the most votes in 
--their election.  Note that if a candidate for office was wrongly declared the winner of their election, more than 
--one other candidate for office in that election might have had more votes. 
--
--Create a view called WronglyDeclaredWinnerView  which identifies the candidates for office who were 
--wrongly declared the winner of their election.  The attributes in the view should include the candidateID, 
--officeID and electionDate (that is, the candidate for office) who was wrongly declared the winner of their 
--election, and also the number of candidates in their election who had more votes.  The attributes in your view 
--should appear as candidateID, officeID, electionDate and numCandidatesWithMoreVotes.  But only include a 
--tuple in the WronglyDeclaredWinnerView if the number of candidates with more votes is at least 2. 
--
--No duplicates should appear in your view. 

CREATE VIEW WronglyDeclaredWinnerView AS
SELECT DISTINCT cfo.candidateID, cfo.officeID, cfo.electionDate, COUNT(*) AS numCandidatesWithMoreVotes
FROM CandidatesForOffice cfo, CandidatesForOffice cfo2
WHERE cfo.officeID = cfo2.officeID AND cfo.electionDate = cfo2.electionDate AND cfo.votes < cfo2.votes AND cfo.wonElection IS TRUE
GROUP BY cfo.candidateID, cfo.officeID, cfo.electionDate
HAVING COUNT(*) >= 2;

--RESULT of the view
SELECT *
FROM WronglyDeclaredWinnerView;