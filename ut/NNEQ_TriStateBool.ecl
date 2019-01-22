/*Function to test your values returned from ut.String2TriStateBool for NOT NOT EQUAL
**INPUT  - two single character strings 
**OUTPUT - are they not "NOT EQUAL"
**EXAMPLES - 

	Y, U	=> TRUE		A U does not disagree with Y because a U might be a Y, so they are not Not Equal
	N, U	=> TRUE		A U does not disagree with N because a U might be an N, so they are not Not Equal
	U, Y	=> TRUE
	U, N	=> TRUE
	Y, Y	=> TRUE		Exact match case
	N, N	=> TRUE		Exact match case
	Y, N	=> FALSE	Disagreement, they are not equal
	N, Y	=> FALSE	Disagreement, they are not equal

**My implementation uses ascii values to avoid the map statement 
**ASCII values
**U - 85
**N - 78
**Y - 89
**N + Y = 167
*/
EXPORT BOOLEAN NNEQ_TriStateBool(STRING1 str1, STRING1 str2) := FUNCTION
	RETURN TRANSFER(str1, INTEGER1) + TRANSFER(str2, INTEGER1) <> 167;					
END;