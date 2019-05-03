import header;
 
 export as_headers_asl := module
 
	Header.Layout_New_Records Translate_ASL_to_Header(files.did2_base l) := transform
	
    string8 v_dob      := l.dob_formatted;
		
		string4 v_dob_yyyy := v_dob[1..4];
		string2 v_dob_mm   := if(v_dob[5..6]='00','01',v_dob[5..6]);
		string2 v_dob_dd   := if(v_dob[7..8]='00','01',v_dob[7..8]);
		
		//don't even populate vendor dates because they can eventually get used in watchdog.bestaddress
		self.did                      := l.did;
    // self.dt_first_seen            := (unsigned3)l.date_first_seen[1..6]; 
    // self.dt_last_seen             := (unsigned3)l.date_last_seen[1..6];
		self.rid                      := 0;
		self.dt_first_seen            := 0;
		self.dt_last_seen             := 0;
		self.dt_vendor_first_reported := (unsigned3)(l.date_vendor_first_reported[1..6]);
		self.dt_vendor_last_reported  := (unsigned3)(l.date_vendor_last_reported[1..6]);
		self.dt_nonglb_last_seen      := self.dt_last_seen;
		self.rec_type                 := '';
		self.vendor_id                := (string)L.key;
		self.phone                    := l.telephone;
		self.ssn                      := '';
		//dob_formatted cleans up the birth_date field
		self.dob                      := if(l.dob_formatted<>'',(integer)(v_dob_yyyy+v_dob_mm+v_dob_dd),0);
		self.suffix                   := l.addr_suffix;
		self.city_name                := l.v_city_name;
		self.county                   := l.fips_county;
		self.cbsa                     := if(l.msa!='',l.msa + '0','');
    self.src                      := l.source;   
   self                          := L;
	end;


export person_header_asl_recs  := project(files.did2_base(fname<>'' and length(trim(lname))>1 and prim_name<>'' and zip<>''),Translate_ASL_to_Header(left));

end;
