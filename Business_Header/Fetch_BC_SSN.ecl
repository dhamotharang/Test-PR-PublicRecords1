
EXPORT Fetch_BC_SSN (UNSIGNED4 ssn_key) := 
	Business_Header.Fetch_BC_Full(Business_Header.Fetch_BC_Key_SSN(ssn_key));