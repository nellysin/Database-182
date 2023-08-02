#! /usr/bin/env python

#  runElectionsApplication Solution

import psycopg2, sys, datetime

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runElectionsApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage

# The three Python functions that for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third Python function).
#
# Write the tests of those function in main, as described in Section 6
# of Lab4.


 # printNumPartyCandidatesAndOfficeHolders (myConn, theParty):
 # party is an attribute in the CandidatesForOffice table, indicating the candidate for office’s
 # party in an election.  A candidate for office in an election runs in a particular party.
 # Every office holder must be a candidate for office (referential integrity), but some
 # candidates for office are office holders and some are not.  Any office holder was in a
 # particular party in the election in which they were candidates for office.
 #
 # The arguments for the printNumPartyCandidatesAndOfficeHolders Python function are the database
 # connection and a string argument, theParty, which is a party.  This Python function prints
 # out the number of candidates for office and the number of offfice holders who were in myParty
 # when they ran as candidates for office in an election.
 #
 # For more details, including error handling and return codes, see the Lab4 pdf.

# printNumPartyCandidatesAndOfficeHolders: This function takes a database connection and the name of a party as input.
# Here you are asked to do a number of things
#   You need to check that theParty has the value NULL and return -1 if it does.
#   You need to find out the number of candidates and officeHolders associated with the party.
#   This number could be 0 in both cases. That is ok.
# Finally print output in the format: 
#   “Number of candidates from party <theParty> is <number of candidates>.”
#   “Number of office holders from party <theParty> is <number of office holders>.”
# Followed by a blank line for readability


def printNumPartyCandidatesAndOfficeHolders (myConn, theParty):
    # Python function to be supplied by students

    try:
        if theParty is None:
            return -1

        myCursor = myConn.cursor() 
        numCandidatesQuery = "SELECT COUNT (*) FROM CandidatesForOffice cfo WHERE cfo.party = %s"
        myCursor.execute(numCandidatesQuery, (theParty,))
        numCandidates = myCursor.fetchone()[0]

        numOfficeHoldersQuery = "SELECT COUNT(*) FROM OfficeHolders oh JOIN CandidatesForOffice cfo ON oh.candidateID = cfo.candidateID AND oh.officeID = cfo.officeID WHERE cfo.party = %s"
        myCursor.execute(numOfficeHoldersQuery, (theParty,))
        numOfficeHolders = myCursor.fetchone()[0]

        print("Number of candidatesc from party", theParty, "is", numCandidates)
        print("Number of office holders from part", theParty, "is", numOfficeHolders)
        print()

    except:
        print("Call of increaseLowSalaries with arguments", theParty, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    myCursor.close()
    return 0

    
    
# end printNumPartyCandidatesAndOfficeHolders


# increaseLowSalaries (myConn, theSalaryIncrease, theLimitValue):
# salary is an attribute of the ElectedOffices table.  We’re going to increase the salary by a
# certain amount (theSalaryIncrease) for all the elected offices who salary value is less than
# or equal some salary limit (theLimitValue).'
#
# Besides the database connection, the increaseLowSalaries Python function has two arguments,
# a float argument theSalaryIncrease and another float argument, theLimitValue.  For every
# elected office in the ElectedOffices table (if any) whose salary is less than or equal to
# theLimitValue, increaseLowSalaries should increase that salary value by theSalaryIncrease.
#
# For more details, including error handling, see the Lab4 pdf.

# This function takes the database connection, theSalaryIncrease, and a theLimitValue as inputs.
# Here you are asked to increase all salaries less than or equal to the limit value.
# If theSalaryIncrease is less than or equal to 0 return -1. If theLimitValue is less than or equal to 0 return -2.
# Otherwise return the number of tuples modified by the function.

def increaseLowSalaries (myConn, theSalaryIncrease, theLimitValue):
    # Python function to be supplied by students
    # You'll need to figure out value to return.
    
    try:
        if theSalaryIncrease <= 0:
            return -1
        if theLimitValue <= 0:
            return -2

        myCursor = myConn.cursor()

        updateSalaryQuery = "UPDATE ElectedOffices SET salary = salary + %s WHERE salary <= %s"
        myCursor.execute(updateSalaryQuery, (theSalaryIncrease, theLimitValue))

    except:
        print("Call of increaseLowSalaries with arguments", theSalaryIncrease, theLimitValue, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    updateSalary = myCursor.rowcount
    myConn.commit()
    myCursor.close()

    return updateSalary


# end increaseLowSalaries


# improveSomeRatings (myConn, theParty, maxRatingImprovements):
# Besides the database connection, this Python function has two other parameters, theParty which
# is a string, and maxRatingImprovements which is an integer.
#
# improveSomeRatings invokes a Stored Function, improveSomeRatingsFunction, that you will need to
# implement and store in the database according to the description in Section 5.  The Stored
# Function improveSomeRatingsFunction has all the same parameters as improveSomeRatings (except
# for the database connection, which is not a parameter for the Stored Function), and it returns
# an integer.
#
# Section 5 of the Lab4 tells you which ratings to improve and how to improve them, and explains
# the integer value that improveSomeRatingsFunction returns.  The improveSomeRatings Python
# function returns the same integer value that the improveSomeRatingsFunction Stored Function
# returns.
#
# improveSomeRatingsFunction doesn’t print anything.  The improveSomeRatings function must only
# invoke the Stored Function improveSomeRatingsFunction, which does all of the work for this part
# of the assignment; improveSomeRatings should not do any of the work itself.
#
# For more details, see the Lab4 pdf.

# improveSomeRatings:  Besides the database connection, this Python function has two other 
# parameters, theParty which is a string, and maxRatingImprovements which is an integer. 
# 
# improveSomeRatings invokes a Stored Function, improveSomeRatingsFunction, that you 
# will need to implement and store in the database according to the description in Section 5.  
# The Stored Function improveSomeRatingsFunction has all the same parameters as 
# improveSomeRatings (except for the database connection, which is not a parameter for the 
# Stored Function), and it returns an integer. 
# 
# Section 5 tells you which ratings to improve and how to improve them, and explains the 
# integer value that improveSomeRatingsFunction returns.  The improveSomeRatings Python 
# function returns the same integer value that the improveSomeRatingsFunction Stored 
# Function returns. 
# 
# improveSomeRatingsFunction doesn’t print anything.  The improveSomeRatings function 
# must only invoke the Stored Function improveSomeRatingsFunction, which does all of the 
# work for this part of the assignment; improveSomeRatings should not do any of the work itself. 

def improveSomeRatings (myConn, theParty, maxRatingImprovements):

# We're giving you the code for improveSomeRatings, but you'll have to write the
# Stored Function improveSomeRatingsFunction yourselves in a PL/pgSQL file named
# improveSomeRatingsFunction.pgsql
        
    try:
        myCursor = myConn.cursor()
        sql = "SELECT improveSomeRatingsFunction(%s, %s)"
        myCursor.execute(sql, (theParty, maxRatingImprovements))

    except Exception as e:
        print(e)
        print("Call of improveSomeRatingsFunction with arguments", theParty, maxRatingImprovements, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

#end improveSomeRatings


def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using myConn.commit when we want to commit.
    
    myConn.autocommit = True
    
    # There are other correct ways of writing all of these calls correctly in Python.
        
    # Perform tests of printNumPartyCandidatesAndOfficeHolders, as described in Section 6 of
    # Lab4.  That Python function handles printing when there is no error.
    # Print error outputs here. You may use a Python method to help you do the printing.

    #TESTING FOR printNumPartCandidatesAndOfficeHolders
    # Test 1: printNumPartyCandidatesAndOfficeHolders with the party 'Silver'
    printTest1 = printNumPartyCandidatesAndOfficeHolders(myConn, 'Silver')
    if printTest1 == 0:
        # Printing happened within the function, do nothing
        pass
    elif printTest1 < 0:
        # An error occurred, print parameters and error message
        print("Error")

    # Test 2: printNumPartyCandidatesAndOfficeHolders with the party 'Copper'
    printTest2 = printNumPartyCandidatesAndOfficeHolders(myConn, 'Copper')
    if printTest2 == 0:
        # Printing happened within the function, do nothing
        pass
    elif printTest2 < 0:
        # An error occurred, print parameters and error message
        print("Error in printNumPartyCandidatesAndOfficeHolders with party 'Copper'")


    # Perform tests of increaseLowSalaries, as described in Section 6 of Lab4.
    # Print their outputs (including error outputs) here, not in increaseLowSalaries.
    # You may use a Python method to help you do the printing.

    #TESTING FOR increaseLowSalaries
    # Test 1: increaseLowSalaries with theSalaryIncrease 6000 and theLimitValue 125000
    increaseTest1 = increaseLowSalaries(myConn, 6000, 125000)
    if increaseTest1 < 0:
        # An error occurred, print parameters and error message
        print("Error in increaseLowSalaries")
        print()
    else:
        # Printing the result
        print(f"Number of elected offices whose salaries under 125000 were updated by 6000 is {increaseTest1}")
        print()

    # Test 2: increaseLowSalaries with theSalaryIncrease 4000 and theLimitValue 131000
    increaseTest2 = increaseLowSalaries(myConn, 4000, 131000)
    if increaseTest2 < 0:
        # An error occurred, print parameters and error message
        print("Error in increaseLowSalaries")
        print()
    else:
        # Printing the result
        print(f"Number of elected offices whose salaries under 131000 were updated by 4000 is {increaseTest2}")
        print()

    #TESTING FOR improveSomeRatings

    # Test 1: improveSomeRatings with theParty 'Copper' and maxRatingImprovements 6
    improveTest1 = improveSomeRatings(myConn, 'Copper', 6)
    print(f"Number of ratings which improved for party Copper for maxRatingImprovements value 6 is {improveTest1}")
    
    print()

    # Test 2: improveSomeRatings with theParty 'Gold' and maxRatingImprovements 1
    improveTest2 = improveSomeRatings(myConn, 'Gold', 1)
    print(f"Number of ratings which improved for party Gold for maxRatingImprovements value 1 is {improveTest2}")
    print()

    # Test 3: improveSomeRatings with theParty 'Silver' and maxRatingImprovements 1
    improveTest3 = improveSomeRatings(myConn, 'Silver', 1)
    print(f"Number of ratings which improved for party Silver for maxRatingImprovements value 1 is {improveTest3}")
    print()

    # Test 4: improveSomeRatings with theParty 'Platinum' and maxRatingImprovements 0
    improveTest4 = improveSomeRatings(myConn, 'Platinum', 0)
    print(f"Number of ratings which improved for party Platinum for maxRatingImprovements value 0 is {improveTest4}")
    print()

    # Test 5: improveSomeRatings with theParty 'Copper' and maxRatingImprovements 6
    improveTest5 = improveSomeRatings(myConn, 'Copper', 6)
    print(f"Number of ratings which improved for party Copper for maxRatingImprovements value 6 is {improveTest5}")
    print()
  



    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
