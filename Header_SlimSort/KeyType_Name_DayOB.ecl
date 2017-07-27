import ut;
h := Header_SlimSort.RawFile_Name_Dayob;

export KeyType_Name_DayOB := 
	{h.mob,
	 h.dayob,
	 string2 alphinit := ut.alphinit2(h.fname[1],h.lname[1]), 
	 h.fname,h.lname,h.mname,h.zip,
     h.dob_fnname_dids,h.dob_fnmname_dids,
     h.dob_fnname_zip_dids,h.dob_fnname_dob_dids,h.did};