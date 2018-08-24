/*Cleans the input Drivers License number
Make DL num upper case.
Strip off any non character, number, * and -s from the DL num.
*/

IMPORT STD;
EXPORT Fn_Clean_DLNumber(STRING dr_lc_num) := FUNCTION
	upperDL := STD.Str.Touppercase(TRIM(dr_lc_num, LEFT, RIGHT));
	//Filter off any non characters, numbers, * and -.
	alphachar := STD.Str.Filter(upperDL, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789*');

	// output(dl_num);
	// output(alphachar);
	
	RETURN alphachar ;
END;