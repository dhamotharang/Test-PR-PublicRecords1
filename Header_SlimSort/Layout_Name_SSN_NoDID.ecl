import header;
h := header.file_headers;
export Layout_Name_SSN_NoDID := record
	h.ssn;
	qstring20 fname := datalib.preferredfirstNew(h.fname, Header_Slimsort.Constants.UsePFNew);
	qstring20 mname := datalib.preferredfirstNew(h.mname, Header_Slimsort.Constants.UsePFNew);
	qstring20 lname := h.lname;
	h.name_suffix;
	//h.dob;
    unsigned2 ssn_dids := 0;
    unsigned2 ssn_fname_dids := 0;
    unsigned2 ssn_fname_suffix_dids := 0;
    unsigned2 ssn_fullname_dids := 0;
  end;