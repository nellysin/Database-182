-- The general constraints for Lab3, which should be written as CHECK constraints, are: 
-- 1) In Contributions, contribution must be greater than zero.  This constraint should be named contributionPositive. 
-- 2) In Elections, officeStartDate must be less than officeEndDate.  This constraint should be named electionStartBeforeEnd. 
-- 3) In CandidatesForOffice, if votes is NULL then wonElection must also be NULL.  This constraint should be named votesNullWonNull. 
--
-- Write commands to add general constraints in the order the constraints are described above, and save your commands to the file general.sql. 
-- Remember that values TRUE and UNKNOWN are okay for a CHECK constraint, but FALSE is not. 

ALTER TABLE Contributions
ADD CONSTRAINT contributionPositive CHECK (contribution > 0);

ALTER TABLE Elections
ADD CONSTRAINT electionStartBeforeEnd CHECK (officeStartDate < officeEndDate);

ALTER TABLE CandidatesForOffice
ADD CONSTRAINT votesNullWonNull CHECK ((votes IS NULL AND wonElection IS NULL) OR (votes IS NOT NULL));