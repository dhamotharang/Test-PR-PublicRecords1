/* Cleans the input SSN 
  o  Keep only digits 0123456789 (filter out anything else).
  o  SSNs that are 7 or 8 digits should be front filled with 0s so that they are 9 digits (Example: 123 4567 would become 001234567)
  o  Remove any SSNs that are in ut.set_badssn
*/
IMPORT STD, ut;

EXPORT Fn_Clean_SSN(STRING ssn = '') := FUNCTION
  ssn_filtered := (STD.Str.Filter( ssn, '0123456789' ));
  ssn_formated := (STRING)(INTFORMAT((INTEGER)ssn_filtered,9,1));
  
  ssn_finished := 
    MAP(
      LENGTH(ssn_filtered) < 7      => '',
      ssn_formated IN ut.set_badssn => '',
      ssn_formated
    );
    
  RETURN ssn_finished;
END;
