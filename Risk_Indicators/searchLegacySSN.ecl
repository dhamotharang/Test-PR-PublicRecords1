/*
 *  This function searches the June 25th, 2011 frozen SSN database by SSN/DID combination.
 *  It returns boolean true/false if the combination is found.
 */
IMPORT data_services, dx_Header;

EXPORT searchLegacySSN (QSTRING9 inSSN, UNSIGNED6 inDID, boolean isFCRA) := FUNCTION
  unsigned1 iType := IF (isFCRA, data_services.data_env.iFCRA, 0);
  key_legacy := dx_Header.key_legacy_ssn (iType);

	found := (TRIM(inSSN) != '') AND (inDID != 0) AND EXISTS(CHOOSEN(key_legacy (ssn = inSSN, did = inDID), 1));

	RETURN(found);
END;
