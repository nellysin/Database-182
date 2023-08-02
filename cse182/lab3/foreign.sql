-- Note that (for example) when we say that each contributor (contributorID) that appears in the 
--Contributions table must appear in the Persons table, that means that the contributorID attribute of the 
--Contributions table is a Foreign Key referring to the Primary Key of the Persons table (which is personID). 
--
--1) Each contributor (contributorID) that appears in the Contributions table must appear in the Persons 
--table as a Primary Key (personID).  If a tuple in the Persons table is deleted, then all Contributions 
--tuples whose contributorID equals that personID should also be deleted.  If the Primary Key
--(personID) of a tuple in the Persons table is updated, then all Contributors tuples whose contributorID 
--equals the updated personID value should be updated to the new personID value. 
--
--2) Each candidate for office (candidateID, officeID, electionDate) that appears in the Contributions table 
--must appear in the CandidatesForOffice table as a Primary Key (candidateID, officeID, electionDate).  
--If a tuple in the CandidatesForOffice table is deleted and there are Contributions tuples which 
--correspond to that candidate for office, then that CandidatesForOffice tuple deletion should be 
--rejected. If a tuple in the CandidatesForOffice table is updated, and there are Contributions tuples 
--which correspond to that candidate for office, then that CandidatesForOffice tuple update should also be rejected. 
--
--3) Each candidate for office (candidateID, officeID, electionDate) that appears in the OfficeHolders table 
--must appear in the CandidatesForOffice table as a Primary Key (candidateID, officeID, electionDate).
--If a tuple in the CandidatesForOffice table is deleted and there are OfficeHolders tuples that 
--correspond to that candidate for office, then all OfficeHolders tuples which correspond to the deleted 
--candidate for office should also be deleted.   If a tuple in the CandidatesForOffice table is updated, and 
--there are OfficeHolders tuples which correspond to that candidate for office, then that CandidatesForOffice tuple update should be rejected. 

ALTER TABLE Contributions
ADD CONSTRAINT fk_contrib_persons FOREIGN KEY (contributorID) REFERENCES Persons(personID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Contributions 
ADD CONSTRAINT fk_contrib_cof FOREIGN KEY (candidateID,officeID,electionDate) REFERENCES CandidatesForOffice(candidateID,officeID,electionDate)
ON DELETE RESTRICT
ON UPDATE RESTRICT;

ALTER TABLE OfficeHolders
ADD CONSTRAINT fk_oh_cof FOREIGN KEY (candidateID,officeID,electionDate) REFERENCES CandidatesForOffice(candidateID,officeID,electionDate)
ON DELETE CASCADE
ON UPDATE RESTRICT;