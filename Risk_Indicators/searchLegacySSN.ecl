/*
 *  This function searches the June 25th, 2011 frozen SSN database by SSN/DID combination.
 *  It returns boolean true/false if the combination is found.
 */
IMPORT doxie, RiskWise;

EXPORT searchLegacySSN (QSTRING9 inSSN, UNSIGNED6 inDID, boolean isFCRA) := FUNCTION
	found := IF(TRIM(inSSN) = '' OR inDID = 0, FALSE, if(isFCRA, EXISTS(CHOOSEN(doxie.Key_FCRA_legacy_ssn (ssn = inSSN, did = inDID), 1)),
																															EXISTS(CHOOSEN(doxie.Key_legacy_ssn (ssn = inSSN, did = inDID), 1))));	// i need an fcra compliant key here

	RETURN(found);
END;