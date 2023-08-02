-- An elected office is identified by its officeID.  A “California elected office” is a tuple in ElectedOffices 
-- whose state is ‘CA’ (with that capitalization).  A particular person has held a particular elected office if 
-- there is a tuple in OfficeHolders which has that person’s personID, and that elected office’s officeID. 
--
-- Write a SQL query which finds each California elected office which at least two different persons have 
-- held.  The attributes in your result should be the elected office’s ID, the elected office’s name, and the
-- elected office’s city, which should appear in your result as theOfficeID, theOfficeName and theOfficeCity.
--
-- No duplicates should appear in your result. 

SELECT DISTINCT eo.officeID AS theOfficeID, eo.officeName AS theOfficeName, eo.city AS theOfficeCity
FROM ElectedOffices eo, OfficeHolders oh1, OfficeHolders oh2
WHERE eo.state = 'CA' AND eo.officeID = oh1.officeID AND eo.officeID = oh2.officeID AND oh1.candidateID <> oh2.candidateID