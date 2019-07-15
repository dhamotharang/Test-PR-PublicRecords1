import codes, ut, idl_header;

in_file := Calbus.Cleaned_Calbus_Addr;

Layout_Out := Calbus.Layouts_Calbus.Layout_AID_Common;

Dist_Cleaned_Calbus := distribute(in_file, hash64(Account_Number));

Srt_Dist_Cleaned_Calbus := sort(Dist_Cleaned_Calbus, Account_Number, Sub_account_number, Account_type, Owner_Name, firm_name, Business_prim_range, Business_prim_name,
                                Business_predir, Business_addr_suffix, Business_postdir, Business_unit_desig, Business_sec_range, 
							    Business_p_city_name, Business_st, Business_zip5, Mailing_prim_range, Mailing_prim_name,
							    Mailing_predir, Mailing_addr_suffix, Mailing_postdir, Mailing_unit_desig, Mailing_sec_range,
							    Mailing_p_city_name, Mailing_st, Mailing_zip5, DISTRICT_BRANCH, DISTRICT, TAX_CODE_FULL, START_DATE,
								INDUSTRY_CODE, OWNERSHIP_CODE, -process_date, local);

Layout_Out  rollupXform(Layout_Out l, Layout_Out r) := transform
	self.Process_Date   := if(l.Process_Date  > r.Process_Date, l.Process_Date, r.Process_Date);
	self.dt_first_seen  := if(l.dt_first_seen > r.dt_first_seen, r.dt_first_seen, l.dt_first_seen);
	self.dt_last_seen   := if(l.dt_last_seen  < r.dt_last_seen,  r.dt_last_seen,  l.dt_last_seen);
	//Started getting Naics codes, so we want to avoid blanks in the resulting field.
	self.naics_code     := if(l.naics_code='', r.naics_code, l.naics_code);
	self                := l;
end;

rolledup_file := rollup(Srt_Dist_Cleaned_Calbus, rollupXform(LEFT,RIGHT), Account_Number, Sub_account_number, Account_type, Owner_Name, firm_name, 
                        Business_prim_range, Business_prim_name, Business_predir, Business_addr_suffix, Business_postdir,
						Business_unit_desig, Business_sec_range, Business_p_city_name, Business_st, Business_zip5, 
						Mailing_prim_range, Mailing_prim_name, Mailing_predir, Mailing_addr_suffix, Mailing_postdir,
						Mailing_unit_desig, Mailing_sec_range, Mailing_p_city_name, Mailing_st, Mailing_zip5, DISTRICT_BRANCH, 
						DISTRICT, TAX_CODE_FULL, START_DATE,  INDUSTRY_CODE, OWNERSHIP_CODE, local);

//*** Code to explode the description values for Filing_type 
Layout_Out  getFilingType(rolledup_file l, codes.File_Codes_V3_In r) := transform
	self.Tax_code_full_desc := If(trim(r.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(r.long_desc,left, right)), '');
	self                    := l;
end;

Filing_file := join(rolledup_file,
		          codes.File_Codes_V3_In(trim(file_name, left, right) = 'CALBUS',trim(field_name, left, right) = 'FILING_TYPE'),
		          trim(left.Tax_code_Full, left, right) = trim(right.code, left, right),
		          getFilingType(LEFT,RIGHT),left outer, lookup);

//*** Code to explode the description values for Ownership_type 
Layout_Out  getOwnershipType(Filing_file l, codes.File_Codes_V3_In r) := transform
	self.Ownership_code_desc := If(trim(r.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(r.long_desc,left, right)), '');
	self                     := l;
end;

Ownership_file := join(Filing_file,
		               codes.File_Codes_V3_In(trim(file_name, left, right) = 'CALBUS',trim(field_name, left, right) = 'OWNERSHIP_TYPE'),
		               trim(left.Ownership_code, left, right) = trim(right.code, left, right),
		               getOwnershipType(LEFT,RIGHT),left outer, lookup);


//*** Code to explode the description values for Business_type 
Layout_Out  getBusinessType(Ownership_file l, codes.File_Codes_V3_In r) := transform
	self.Industry_code_desc := If(trim(r.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(r.long_desc,left, right)), '');
	self                    := l;
end;

Business_file := join(Ownership_file,
		               codes.File_Codes_V3_In(trim(file_name, left, right) = 'CALBUS',trim(field_name, left, right) = 'BUSINESS_TYPE'),
		               trim(left.INDUSTRY_CODE, left, right) = trim(right.code, left, right),
		               getBusinessType(LEFT,RIGHT),left outer, lookup);

//*** Code to explode the description values for County_type 
Layout_Out  getCountyType(Business_file l, codes.File_Codes_V3_In r) := transform
	self.County_code_desc := If(trim(r.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(r.long_desc,left, right)), '');
	self                  := l;
end;

County_file := join(Business_file,
		            codes.File_Codes_V3_In(trim(file_name, left, right) = 'CALBUS',trim(field_name, left, right) = 'COUNTY_CODE'),
		            trim(left.COUNTY_CODE, left, right) = trim(right.code, left, right),
		            getCountyType(LEFT,RIGHT),left outer, lookup);

export Update_Calbus := County_file : persist(Calbus.Constants.Cluster + 'persist::CALBUS::Updated_Calbus');
