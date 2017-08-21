import ut, Address, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog, cellphone, lib_stringlib;

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

/* Only Updates are through mapping portion. ALL records run through DID process b/c build is monthly */

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

export Map_InstantID_Logs_Base(string filedate) := function

/* Project - Name and Address Cleaning */
instantid_logs.Layout_InstantID_Logs_Base tClean(instantid_logs.Layout_InstantID_Logs l) := transform

/* 	Clean Addresses */
	inADDRESS1 := l.orig_address;
	inADDRESS2 := l.orig_city + ' ' + l.orig_state + ' ' + l.orig_zip + l.orig_zip4;
  clean_addr := address.CleanAddress182(inAddress1, inaddress2);

/* 	Clean Names */
	clean_name :=if(l.orig_fname = l.orig_lname or (l.orig_lname <> '' and
								  StringLib.StringFind(' ' + StringLib.StringCleanSpaces(l.orig_fname) + ' ', ' ' + StringLib.StringCleanSpaces(l.orig_lname) + ' ',1) > 0 and
								  StringLib.StringFind(StringLib.StringCleanSpaces(l.orig_fname), ' ',1) > 0), 
							instantid_logs.Clean_n_Validate(l.orig_fname, 'F').cleannamerecord, 
							instantid_logs.Clean_n_Validate(l.orig_fname + ' ' + l.orig_mname + ' ' + l.orig_lname, 'F').cleannamerecord);
							
/* Select Businesses */
	businessPREP := if(l.orig_fname = l.orig_lname or (l.orig_lname <> '' and 
								  StringLib.StringFind(' ' + StringLib.StringCleanSpaces(l.orig_fname) + ' ', ' ' + StringLib.StringCleanSpaces(l.orig_lname) + ' ',1) > 0 and
								  StringLib.StringFind(StringLib.StringCleanSpaces(l.orig_fname), ' ',1) > 0), 
							l.orig_fname,stringlib.stringcleanspaces(l.orig_fname + ' ' + l.orig_mname + ' ' + l.orig_lname));
  business := if(ut.IsCompany(businessPREP), businessPREP, if(regexfind('[^A-Za-z]', l.orig_fname + l.orig_lname), '', businessPREP));
	
/*  Clean Date */
	clean_date(string indate) := function	
		numbersonly := stringlib.stringfilter(indate, '0123456789')[1..8];
		valid_date := if(numbersonly[1..2] between '01' and '12' and 
											numbersonly[3..4] between '01' and '31' and
											numbersonly[5..8] between '1901' and ut.GetDate[1..4], true, false);
		date_extract := if(valid_date, numbersonly[5..8]+numbersonly[1..4], '');
	return date_extract;
	end;
	
/*  Check DOB */
	clean_dob(string indate) := function	
		numbersonly := stringlib.stringfilter(indate, '0123456789')[1..8];
		valid_mm := numbersonly[5..6] between '01' and '12'; 
		valid_dd := numbersonly[7..8] between '01' and '31';
		valid_yyyy := numbersonly[1..4] between '1901' and ut.GetDate[1..4];
		date_extract := map(valid_yyyy and valid_dd and valid_mm => numbersonly,
												valid_yyyy and valid_dd  => numbersonly[1..6],
												valid_yyyy  => numbersonly[1..4], '');
	return date_extract;
	end;
	
/*  Assign Fields */

  self.date_first_seen := clean_date(l.orig_dateadded);
	self.date_last_seen :=  clean_date(l.orig_dateadded);
  self.process_date := filedate[1..8];

	self.title	 := clean_name.title;
	self.fname	 := clean_name.fname;
	self.mname	 := clean_name.mname;
	self.lname	 := clean_name.lname;
	self.name_suffix	 := clean_name.name_suffix;
	self.name_score	 := clean_name.name_score;
	
	self.cname		:= business;
	
	self.dob := clean_dob(l.orig_dob);
	
	self.ssn := (string)intformat((unsigned8)l.orig_ssn, 9, 0);
	
	self.prim_range := clean_addr[1..10];
	self.predir := clean_addr[11..12];
	self.prim_name := clean_addr[13..40];
	self.addr_suffix := clean_addr[41..44];
	self.postdir := clean_addr[45..46];
	self.unit_desig := clean_addr[47..56];
	self.sec_range := clean_addr[57..64];
	self.p_city_name := clean_addr[65..89];
	self.v_city_name := clean_addr[90..114];
	self.st := clean_addr[115..116];
	self.zip := clean_addr[117..121];
	self.zip4 := clean_addr[122..125];
	self.cart := clean_addr[126..129];
	self.cr_sort_sz := clean_addr[130];
	self.lot := clean_addr[131..134];
	self.lot_order := clean_addr[135];
	self.dbpc := clean_addr[136..137];
	self.chk_digit := clean_addr[138];
	self.rec_type := clean_addr[139..140];
	self.county := clean_addr[141..145];
	self.geo_lat := clean_addr[146..155];
	self.geo_long := clean_addr[156..166];
	self.msa := clean_addr[167..170];
	self.geo_blk := clean_addr[171..177];
	self.geo_match := clean_addr[178];
	self.err_stat := clean_addr[179..182];
	
	self.phone := Cellphone.CleanPhones(L.orig_phone);

  self.ptrack := (string60)hash(self.fname, self.lname, self.p_city_name, self.st, self.zip);

	self := l;
end;

/* Remove Update Duplicates and concatenate Previous Base */
cleanedLogs := dedup(project(instantid_logs.File_InstantID_Logs, tClean(left)) + instantid_logs.File_InstantID_Logs_Base, record, except orig_dateadded, except orig_company_id, all)(orig_address <> 'address');

/* Assign DID to all records */

matchset := ['A', 'D', 'S', 'P'];

DID_Add.MAC_Match_Flex(cleanedLogs, matchset,
	 orig_ssn, dob, fname, mname,lname,name_suffix, 
	 prim_range, prim_name, sec_range,zip, st, phone,
	 DID,instantid_logs.Layout_InstantID_Logs_Base, 
	 true, DID_Score,	75,	precleanedLogs_DID);
	 
cleanedLogs_DID := precleanedLogs_DID 	: persist('~thor_data400::persist::instantid_did');
	 
/* Assign Date first and last seen */

full_sort := sort(distribute(cleanedLogs_DID, hash(orig_fname, orig_lname, orig_Address, orig_city, orig_zip4)), orig_fname, orig_lname, orig_mname, orig_Address, orig_city, orig_state, orig_zip, orig_zip4, orig_Phone, orig_SSN, orig_DOB,local);

filt_full := InstantID_Logs.fn_filter_by_companyid(full_sort);

instantid_logs.Layout_InstantID_Logs_Base rollup_records(instantid_logs.Layout_InstantID_Logs_Base L, instantid_logs.Layout_InstantID_Logs_Base R) := transform
		self.dateadded_extended := trim(l.orig_dateadded+ ';' +  r.orig_dateadded, all);
		self.date_first_seen := if(l.date_first_seen > r.date_first_seen and r.date_first_seen <> '', r.date_first_seen, l.date_first_seen);
		self.date_last_seen  := if(l.date_last_seen  < r.date_last_seen,  r.date_last_seen,  l.date_last_seen);
		self.company_id_extended := trim(l.orig_company_id + ';' +  r.orig_company_id, all);
		self.process_date  := if(l.process_date  < r.process_date,  r.process_date,  l.process_date);
		self := l;
end;

full_dedup := rollup(filt_full, rollup_records(left, right), orig_fname, orig_lname, orig_mname, orig_Address, orig_city, orig_state, orig_zip, orig_zip4, orig_Phone, orig_SSN, orig_DOB, record, local)	: persist('~thor_data400::persist::instantid_base');


return full_dedup;

end;