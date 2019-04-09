IMPORT ut, std;
/*
*** VALID SSN flags from header
G=good; 
F=fatfingers(typo; one or two digits off in the same positions)
R=relative ; B=bad ; O=old (SSA issued before individual's DOB)
Z= ssn matches best_ssn, but someone else owns it
U=unknown 
 M=SSN in the records is manufactured; it cam from watchdog non-GLB best if available
 M is populated in the keys only.  base file does not contain M.
*/
EXPORT fn_valid_ssn(string s, string src) := FUNCTION
	words := Std.Str.SplitWords(s, '|');
	return IF(words[2]='G', true, false);
END;

//						ut.isNumeric(s) and length(trim(s))=9 AND
//													s not in ut.set_badssn;
