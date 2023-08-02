--For each of the 3 foreign key constraints specified in section 2.3, write one unit test: 
--  1) An INSERT command that violates the foreign key constraint (and elicits an error).  You must violate 
--      that specific foreign key constraint, not any other constraint.
--
--Also, for each of the 3 general constraints, write 2 unit tests, with 2 tests for the first general constraint, 
--followed by 2 tests for the second general constraint, followed by 2 tests for the third general constraint. 
--
--  2) An UPDATE command that meets the constraint. 
--  3) An UPDATE command that violates the constraint (and elicits an error). 

--INSERT command that violates the foreign key constraint (and elicits an error)

--Reference contributorID from controbutions in persons
INSERT INTO Contributions(contributorID, candidateID, officeID, electionDate, contribution)
VALUES (35, 30, 300, DATE '2021-2-5', 11000.00);

--Reference candidateID, officeID, electionDate from contributions in CandidatesForOffice
INSERT INTO Contributions(contributorID, candidateID, officeID, electionDate, contribution)
VALUES (45, 40, 30, DATE '2022-12-12', 5000.00);

--Reference candidateID, officeID, electionDate from OfficeHolders in CandidatesForOffice
INSERT INTO OfficeHolders(candidateID, officeID, electionDate, rating)
VALUES (55, 450, DATE '2022-4-5', 'F');

--1) In Contributions, contribution must be greater than zero.  
-- meets the constraint
UPDATE Contributions
SET contribution = 67000.00
WHERE contributorID = 11 AND candidateID = 1 AND officeID = 101 AND electionDate = DATE '1/31/18';

-- violates the constraint
UPDATE Contributions
SET contribution = -55000.00
WHERE contributorID = 11 AND candidateID = 1 AND officeID = 101 AND electionDate = DATE '1/31/18';

-- 2) In Elections, officeStartDate must be less than officeEndDate.  
-- meets the constraint
UPDATE Elections
SET officeStartDate = DATE '5/1/21' , officeEndDate = DATE '5/29/21'
WHERE officeID = 102 AND electionDate = DATE '4/21/15';

-- violates the constraint
UPDATE Elections
SET officeStartDate = DATE '5/29/21' , officeEndDate = DATE '5/1/21'
WHERE officeID = 102 AND electionDate = DATE '4/21/15';

-- 3) In CandidatesForOffice, if votes is NULL then wonElection must also be NULL.  
-- meets the constraint
UPDATE CandidatesForOffice
SET party = 'Gold', votes = NULL, totalContributions = '108000.00', wonElection = NULL
WHERE candidateID = 3 AND officeID = 101 AND electionDate = DATE '1/31/18';

-- violates the constraint
UPDATE CandidatesForOffice
SET party = 'Gold', votes = NULL, totalContributions = '108000.00', wonElection = TRUE
WHERE candidateID = 3 AND  officeID = 101;