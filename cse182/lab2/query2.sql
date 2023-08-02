-- A candidate for office in a specific election is a Gold party candidate if the candidate’s party in that 
-- specific election is ‘Gold’.  (Candidates might run not have the same party in other elections.) 
--
-- For each person who contributed to a Gold party candidate for office in an election, find the name of the
-- contributor, the name of the candidate, and the amount of the contribution.  The attributes in your result 
-- should appear as contributorName, candidateName and contribution.
--
-- Tuples in your result with larger contributions should appear before tuples that have smaller 
-- contributions.  If two result tuples have the same contribution,  then they should appear in alphabetical 
-- order based on the name of the contributor.
--
-- Do not eliminate duplicates from your result. 

SELECT p.personName AS contributorName, p2.personName AS candidateName, cont.contribution AS contribution
FROM Contributions cont, Persons p, Persons p2, CandidatesForOffice cfo
WHERE cfo.party = 'Gold' AND cont.candidateID = cfo.candidateID AND cont.contributorID = p.personID AND cfo.candidateID = p2.personID AND cont.electionDate = cfo.electionDate 
ORDER BY cont.contribution DESC, p.personName ASC;