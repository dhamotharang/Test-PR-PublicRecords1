IMPORT ut;

EXPORT MAC_lname_fname(inkey, lname_fil, fname_fil) := MACRO
	// enable 'starts with' matching on the input lname *and* safeguard against invalid subrange exception
	#uniquename(castLname)
		%castLname% := TRIM(ut.cast2keyfield(inkey.lname,_lname));
		lname_fil := inkey.lname IN _lname_set OR (_row.tname.leading_name_match and temp_lname_trailing_value
		and inkey.lname[1..length(%castLname%)] = %castLname%);
								 
	#uniquename(castFname)
    %castFname% := TRIM(ut.cast2keyfield(inkey.fname,_fname));
    fname_fil := _fname_set = [] OR inkey.fname IN _fname_set OR 
									((NOT _row.tname.leading_name_match or temp_lname_trailing_value) AND inkey.fname[1..length(%castFname%)] = %castFname%);
	ENDMACRO;