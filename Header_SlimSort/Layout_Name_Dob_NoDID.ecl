import header,ut;
h := header.file_headers;
export Layout_Name_DOB_NoDID := record
	h.zip;
	qstring20 fname := datalib.preferredfirstNew(h.fname, Header_Slimsort.Constants.UsePFNew);
	qstring20 mname := datalib.preferredfirstNew(h.mname, Header_Slimsort.Constants.UsePFNew);
	qstring20 lname := h.lname;
	integer4 mob := ut.mob(h.dob);
    unsigned2 dob_fnname_dids := 0;
    unsigned2 dob_fnmname_dids := 0;
    unsigned2 dob_fnname_zip_dids := 0;
  end;