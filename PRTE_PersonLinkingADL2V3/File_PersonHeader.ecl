import header,ut, prte;

// h := header.fn_filter_for_keys_and_slimsorts(header.file_headers,true);
h:= header.fn_filter_for_keys_and_slimsorts(PRTE.File_PRTE_Header);

hout := project(h,
                transform(Layout_PersonHeader,
				          self.city := left.city_name,
						  self.state := left.st,
						  self.dob := (qstring8)if(left.dob <> 0, intformat(left.dob, 8, 1), '');
                          self.ssn5 := left.ssn[1..5];
						  self.ssn4 := left.ssn[6..9];
						  self := left));

export File_PersonHeader := hout;
