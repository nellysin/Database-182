--The Fraudulent Officeholder query uses the WronglyDeclaredWinnerView, and (possibly) some other tables.
--In addition to writing the Fraudulent Officeholder query, you must also include some comments in the queryview.sql script; we’ll describe those necessary comments below. 
--
--There’s a third way that we can tell that a candidate for office won their election. 
--If a candidate for office in an election is also the office holder for that election, then we’ll say that the candidate for office holds the office they ran for in their election. 
--
--Write and run a SQL query which finds the candidateID, personName, officeID and electionDate of the 
--candidates for office who appear in WronglyDeclaredWinnerView, and who also hold the office they ran for in 
--their election.  (A candidate must be a person, so it’s easy to find a candidate’s personName.)  
--No duplicates should appear in your result. 
--
--Then write the results of the Fraudulent Officeholder query in a comment.  The format of that comment is not 
--important; the comment just has to have all the right information in it. 
--
--Next, write a SQL statement that performs the following update in the CandidatesForOffice table: 
--  1) Updates the wonElection attribute for the tuple in CandidatesForOffice table whose Primary Key 
--      is (9, 106, 2005-05-15) to FALSE. 
--
-- Run the Fraudulent Officeholder query once again after that update.  Write the output of the query in a second comment.  Do you get a different answer? 
--
-- You need to submit a script named queryview.sql containing your query on the views. In that file you must include:  
--  1) Your Fraudulent Officeholder SQL query
--  2) A comment with the output of that query on the load data before the update. 
--  3) A SQL statement which performs the update described above. 
--  4) Repeat your Fraudulent Officeholder SQL query. 
--  5) A second comment with the output of that query after the update.  

SELECT DISTINCT w.candidateID, p.personName, w.officeID, w.electionDate
FROM WronglyDeclaredWinnerView w, Persons p, CandidatesForOffice cfo, OfficeHolders oh
WHERE w.candidateID = cfo.candidateID
    AND w.officeID = cfo.officeID
    AND w.electionDate = cfo.electionDate

    AND w.candidateID = oh.candidateID
    AND w.officeID = oh.officeID
    AND w.electionDate = oh.electionDate

    AND cfo.candidateID = oh.candidateID
    AND cfo.officeID = oh.officeID
    AND cfo.electionDate = oh.electionDate

    AND p.personID = cfo.candidateID
    AND p.personID = w.candidateID

    AND cfo.wonElection = TRUE;

-- RESULTS of the Fraudulent Officeholder SQL query
/* candidateid |    personname    | officeid | electiondate 
-------------+------------------+----------+--------------
           3 | Alexander Hilton |      101 | 2018-01-31
           9 | Penny Taylor     |      106 | 2005-05-15
(2 rows)*/

UPDATE CandidatesForOffice
SET wonElection = FALSE
WHERE candidateID = 9 AND officeID = 106 AND electionDate = DATE '2005-05-15';

SELECT DISTINCT w.candidateID, p.personName, w.officeID, w.electionDate
FROM WronglyDeclaredWinnerView w, Persons p, CandidatesForOffice cfo, OfficeHolders oh
WHERE w.candidateID = cfo.candidateID
    AND w.officeID = cfo.officeID
    AND w.electionDate = cfo.electionDate

    AND w.candidateID = oh.candidateID
    AND w.officeID = oh.officeID
    AND w.electionDate = oh.electionDate

    AND cfo.candidateID = oh.candidateID
    AND cfo.officeID = oh.officeID
    AND cfo.electionDate = oh.electionDate

    AND p.personID = cfo.candidateID
    AND p.personID = w.candidateID

    AND cfo.wonElection = TRUE;

-- RESULTS of the updated Fraudulent Officeholder SQL query
/*UPDATE 1
 candidateid |    personname    | officeid | electiondate 
-------------+------------------+----------+--------------
           3 | Alexander Hilton |      101 | 2018-01-31
(1 row)

Do you get a different answer? 
Yes, Penny Taylor is not in this result since we have updated this candidates' wonElection to FALSE*/