CREATE OR REPLACE FUNCTION improveSomeRatingsFunction(theParty VARCHAR(20), maxRatingImprovements INTEGER)
RETURNS INT AS $$
DECLARE
    improvementsCount INTEGER := 0;   -- Number of improvements made
    theCandidateID INTEGER;   -- The ID of the office holder
    ratingImprove CHAR(1);
    theOfficeID INTEGER;
    theElectionDate DATE;

    -- Declare the cursor for fetching the office holders
DECLARE ratingCursor CURSOR FOR
    SELECT oh.candidateID, oh.officeID, oh.electionDate, oh.rating
    FROM OfficeHolders oh
    JOIN CandidatesForOffice cfo ON oh.candidateID = cfo.candidateID AND oh.officeID = cfo.officeID AND oh.electionDate = cfo.electionDate
    WHERE cfo.party = theParty AND oh.rating IN ('B', 'C', 'D', 'F')
    ORDER BY oh.electionDate DESC;

BEGIN
    -- Input Validation
    IF maxRatingImprovements <= 0 THEN
        RETURN -1;  -- Illegal value of maxRatingImprovements
    END IF;

    -- Open the cursor
    OPEN ratingCursor;

    LOOP
        -- Fetch the next office holder
        FETCH ratingCursor INTO theCandidateID, theOfficeID, theElectionDate, ratingImprove;

        -- Exit if there are no more office holders to improve ratings for
        EXIT WHEN NOT FOUND OR improvementsCount >= maxRatingImprovements;

        -- Update the rating for the office holder using CASE
        UPDATE OfficeHolders
        SET rating = CASE
            WHEN rating = 'B' THEN 'A'
            WHEN rating = 'C' THEN 'B'
            WHEN rating = 'D' THEN 'C'
            WHEN rating = 'F' THEN 'D'
            ELSE rating
        END
        WHERE candidateID = theCandidateID
        AND rating = ratingImprove
        AND officeID = theOfficeID
        AND electionDate = theElectionDate;

        improvementsCount := improvementsCount + 1;
    END LOOP;

    -- Close the cursor
    CLOSE ratingCursor;

    -- Return the number of improvements made
    RETURN improvementsCount;
END;
$$ LANGUAGE plpgsql;
