/* Cleans the input SSN 
  o  Keep only digits 0123456789 (filter out anything else).
  o  SSNs that are 7 or 8 digits should be front filled with 0s so that they are 9 digits (Example: 123 4567 would become 001234567)
  o  Remove any SSNs that are in ut.set_badssn
	o  Remove any SSNs with invalid characteristics (NOTE: These rules do not apply to TINs, only SSNs):
			- First three digits are 000, 666 or 900-999
			- Fourth and fifth digits are 00
			- Digits 6-9 are 0000

*/
IMPORT STD, ut;

EXPORT Fn_Clean_SSN(STRING ssn = '', BOOLEAN IsTIN = FALSE) := FUNCTION
  ssn_filtered := (STD.Str.Filter( ssn, '0123456789' ));
  ssn_formatted := (STRING)(INTFORMAT((INTEGER)ssn_filtered,9,1));
  
  ssn_finished := 
    MAP(
      LENGTH(ssn_filtered) < 7      											=> '',
      ssn_formatted IN ut.set_badssn 											=> '',
			NOT IsTIN AND ssn_formatted[1..3] IN ['000', '666'] => '',
			NOT IsTIN AND ssn_formatted[1] = '9' 								=> '',
			NOT IsTIN AND ssn_formatted[4..5] = '00'						=> '',
			NOT IsTIN AND ssn_formatted[6..9] = '0000' 					=> '',
      ssn_formatted
    );
    
  RETURN ssn_finished;
END;
