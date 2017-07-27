import doxie;
export get_ContactsByDID(dataset(doxie.layout_references) dids) := 
FUNCTION
bhfc := Business_Header.File_Business_Contacts_Plus;

TYPEOF(bhfc) TakeRight(bhfc r) := TRANSFORM
	SELF := r;
END;

// Pull matching DID's from the header
dd1_match := JOIN(
	dids,
	bhfc,
	LEFT.did = RIGHT.did,
	TakeRight(RIGHT),
	KEYED(Business_Header.Key_Business_Contacts_DID),
	limit(10000, skip));
	

return dd1_match;

END;