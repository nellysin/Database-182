-- Indexes are data structures used by the database to improve query performance.  An election is identified by (officeID, electionDate).
-- Locating any tuple in the OfficeHolders table for a particular officeID and electionDate might be slow, 
-- if the database system has to search the entire OfficeHolders table (if the number of OfficeHolders was very large).
-- To speed up that search, create an index named OfficeHolderForElection over the officeID and electionDate columns (in that order) of the OfficeHolders table.
-- Save the command in the file createindex.sql. 
--
-- Of course, you can run the same SQL statements whether or not this index exists; having indexes just changes the performance of SQL statements.
-- But this index could make it faster to find all persons who have held a particular elected office. 
-- It could also be used by the database system to help guarantee that there can’t be more than one office holder for a particular election, i.e., that (officeID, electionDate) is UNIQUE in OfficeHolders. 

CREATE INDEX OfficeHolderForElection ON OfficeHolders(officeID, electionDate);