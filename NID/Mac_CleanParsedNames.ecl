export Mac_CleanParsedNames(inFile, outFile,
		firstname='fname',middlename='mname',lastname='lname',namesuffix='name_suffix',
		fullname='fullname',
		nameid = 'nid',
		namtype = 'nametype',		// name type field
		_title = 'cln_title',		// cleaned title field
		_fname = 'cln_fname',		// cleaned first name field
		_mname = 'cln_mname',		// cleaned middle name field
		_lname = 'cln_lname',		// cleaned last name field
		_suffix = 'cln_suffix',	// cleaned suffix field
		_title2 = 'cln_title2',	// cleaned title for name 2
		_fname2 = 'cln_fname2',	// cleaned first name for name 2
		_mname2 = 'cln_mname2',	// cleaned middle name for name 2
		_lname2 = 'cln_lname2',	// cleaned last name for name 2
		_suffix2 = 'cln_suffix2',	// cleaned suffix for name 2
		_name_ind = 'name_ind',	// name indicator. See Nid.NameIndicators
includeInRepository=true,
normalizeDualNames=false,
useV2 = false,								// use new repository 
_chkpoint=1
) := MACRO

		outFile := Nid.fn_CleanParsedNames(inFile, firstname,middlename,lastname,namesuffix,fullname,
			nameid,
			namtype,		// name type field
			_title,		// cleaned title field
			_fname,		// cleaned first name field
			_mname,		// cleaned middle name field
			_lname,		// cleaned last name field
			_suffix,	// cleaned suffix field
			_title2,	// cleaned title for name 2
			_fname2,	// cleaned first name for name 2
			_mname2,	// cleaned middle name for name 2
			_lname2,	// cleaned last name for name 2
			_suffix2,	// cleaned suffix for name 2
			_name_ind,	// name indicator. See Nid.NameIndicators
			includeInRepository,
			normalizeDualNames,
			useV2);


ENDMACRO;
