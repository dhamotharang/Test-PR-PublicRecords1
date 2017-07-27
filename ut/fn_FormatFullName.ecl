
	SHARED STRING FormatLastName(STRING lastname = '', STRING firstname = '', STRING middlename = '') :=
		FUNCTION
			name := IF( LENGTH(TRIM(lastname)) > 0 AND (LENGTH(TRIM(firstname)) > 0 OR LENGTH(TRIM(middlename)) > 0), 
			            TRIM(lastname) + ', ',
                  TRIM(lastname)
                 );
			RETURN name;
		END;
	
	SHARED STRING FormatFirstName(STRING firstname = '', STRING middlename = '') :=
		FUNCTION
			name := IF( LENGTH(TRIM(firstname)) > 0 AND (LENGTH(TRIM(middlename)) > 0), 
			            TRIM(firstname) + ' ',
                  TRIM(firstname)
                 );
								 
			RETURN name;
		END;
		
	// The following function returns a full name formatted as: 'LastName, FirstName MiddleName'. It takes
	// into account missing name types, too.
	EXPORT STRING fn_FormatFullName(STRING lastname = '', STRING firstname = '', STRING middlename = '') :=
		FUNCTION
			RETURN FormatLastName(lastname, firstname, middlename) + 
			       FormatFirstName(firstname, middlename) + 
						 TRIM(middlename);
		END;
