import header, prte2_header, idl_header, ut;

// cust_header := PRTE.File_PRTE_Header;
cust_header := prte2_header.files.file_headers_base;

hdrC := PROJECT(cust_header, transform(idl_header.layout_xLink,
			 SELF.source_rid := left.rid,
			 SELF.addr_suffix := left.suffix;
			 SELF.sname := left.name_suffix;			 
			 SELF.city := left.city_name;
			 STRING5 ssn5_temp := (STRING)LEFT.SSN[1..5];
			 STRING4 ssn4_temp := (STRING)LEFT.SSN[6..9];
			 SELF.ssn5 := if (ssn5_temp <> '00000', ssn5_temp, '');
			 SELF.ssn4 := if (ssn4_temp <> '0000', ssn4_temp, '');			 
			 SELF := LEFT, 
			 SELF := []));
			 
export CustTest_Header := hdrC;
