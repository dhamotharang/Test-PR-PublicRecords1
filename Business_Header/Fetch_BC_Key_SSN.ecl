keyfile := Business_Header.Key_Business_Contacts_SSN;
outrec := Business_Header.layout_filepos;

export Fetch_BC_Key_SSN(UNSIGNED4 ssn_key) := 
	project(keyfile (ssn = ssn_key), transform(outrec, self := left));