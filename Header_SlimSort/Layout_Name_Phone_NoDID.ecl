import header;
h := header.file_headers;
export Layout_Name_Phone_NoDID := record
	h.phone;
	qstring20 fname := datalib.preferredfirstNew(h.fname, Header_Slimsort.Constants.UsePFNew);
	qstring20 mname := datalib.preferredfirstNew(h.mname, Header_Slimsort.Constants.UsePFNew);
	qstring20 lname := h.lname;
	h.name_suffix;
    unsigned2 phone_dids := 0;
    unsigned2 phone_fname_dids := 0;
    unsigned2 phone_fname_suffix_dids := 0;
    unsigned2 phone_fullname_dids := 0;
end;