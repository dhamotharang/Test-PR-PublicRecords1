//Remember to set _PRTE_BUILD := TRUE; in PRTE2_Header.Constants before building.

IMPORT PRTE2_Person_Header_Lookups;

EXPORT proc_build_all(string filedate) := FUNCTION

	return PRTE2_Person_Header_Lookups.proc_build_keys(filedate);

END;