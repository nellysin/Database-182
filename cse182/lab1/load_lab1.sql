-- Sample Script file to Populate Elections Schema
-- Populate the tables

-- Persons(personID, personName, city, state, occupation, isFelon)
COPY Persons FROM stdin USING DELIMITERS '|';
1|John Doe|New York|NY|Teacher|TRUE
2|Jane Doe|Houston|TX|Doctor|FALSE
3|Alexander Hilton|Detroit|MI|Software Engineer|FALSE
4|Jefferson Thomas|Seattle|WA|Writer|FALSE
5|Javier Lopez|Las Vegas|NV|Professor|TRUE
6|Kaitlin Mayer|Atlanta|GA|CEO|TRUE
7|Casey Corvez|Austin|TX|Project Manager|TRUE
8|Thomas Seo|Pheonix|AZ|Registered Nurse|FALSE
9|Penny Wood|Los Angeles|CA|Chef|TRUE
10|Jenny Davis|Dallas|TX|Librarian|TRUE
11|Brad Parker|Los Angeles|TN|Investor|TRUE
12|Leo Hill|Birmingham|AL|Financial Planner|FALSE
13|Joseph Williams|Boise|ID|Business Analyst|TRUE
14|Snow Lewis|Kansas City|KS|CTO|TRUE
15|Steven Martin|Salt Lake City|UT|Restaurant Manager|TRUE
\.

-- ElectedOffices(officeID, officeName, city, state, salary)
COPY ElectedOffices FROM stdin USING DELIMITERS '|';
101|Senator|Sacramento|CA|150000.00
102|President|Washington DC|DC|100000.00
103|Commissioner|Chicago|IL|120000.00
104|Representative|Riverside|CA|125000.00
105|Governor|Tampa|FL|250000.00
106|Mayor|New York City|NY|300000.00
107|Attorney General|Charlotte|NC|40000.00
\.


-- Elections(officeID, electionDate, officeStartDate, officeEndDate)
COPY Elections FROM stdin USING DELIMITERS '|';
101|1/31/18|2/15/18|2/2/20
102|4/21/15|4/25/15|4/26/19
104|2/17/20|3/2/20|3/3/25
103|10/29/21|11/1/21|11/2/23
106|5/15/05|5/31/05|6/20/09
105|12/31/99|1/11/00|1/3/07
101|6/6/79|6/20/79|9/8/84
107|7/19/87|7/25/87|10/20/91
\.

-- CandidatesForOffice(candidateID, officeID, electionDate, party, votes, totalContributions, wonElection)
COPY CandidatesForOffice FROM stdin USING DELIMITERS '|';
1|101|1/31/18|Gold|123489|50200.00|TRUE
2|101|1/31/18|Silver|136842|6070.50|FALSE
3|103|10/29/21|Copper|9810247|20360.00|TRUE
4|103|10/29/21|Platinum|1038112|10080.00|FALSE
5|105|12/31/99|Gold|255105|15073.20|TRUE
6|105|12/31/99|Silver|985430|50105.00|FALSE
7|101|6/6/79|Copper|57992|4200.00|TRUE
8|101|6/6/79|Platinum|48279|36000.00|FALSE
9|101|6/6/79|Gold|5201|230000.00|FALSE
10|107|7/19/87|Silver|254876|40025.00|FALSE
5|107|7/19/87|Copper|50592|765000.30|TRUE
6|104|2/17/20|Platinum|14133|3200.00|FALSE
10|104|2/17/20|Gold|30649|60060.00|TRUE
5|102|4/21/15|Silver|15880718|7010.00|FALSE
7|102|4/21/15|Copper|20717020|50200.00|TRUE
8|106|5/15/05|Platinum|1625401|82000.00|FALSE
9|106|5/15/05|Gold|6581032|12600.50|TRUE
\.

-- Contributions(contributorID, candidateID, officeID, electionDate, contribution)
COPY Contributions FROM stdin USING DELIMITERS '|';
11|1|101|1/31/18|50000.00
12|2|101|1/31/18|6000.50
13|3|103|10/29/21|20000.00
14|4|103|10/29/21|10000.00
15|5|105|12/31/99|15000.20
11|6|105|12/31/99|50000.00
12|7|101|6/6/79|50105.00
13|8|101|6/6/79|4000.00
14|9|101|6/6/79|30000.00
15|10|107|7/19/87|23000.00
11|5|107|7/19/87|4000.00
12|6|104|2/17/20|70000.30
13|10|104|2/17/20|3000.00
14|5|102|4/21/15|6006.00
15|7|102|4/21/15|50000.00
11|7|102|4/21/15|200.00
12|8|106|5/15/05|82000.00
13|9|106|5/15/05|11000.25
10|9|106|5/15/05|1000.25
\.

-- OfficeHolders(candidateID, officeID, electionDate, rating)
COPY OfficeHolders FROM stdin USING DELIMITERS '|';
1|101|1/31/18|A
3|103|10/29/21|B
5|105|12/31/99|C
7|101|6/6/79|D
5|107|7/19/87|A
10|104|2/17/20|B
7|102|4/21/15|C
9|106|5/15/05|D
\.
