import Business_Header, ut, mdr, _validate;

export fFL_Non_Profit_As_Business_Contact(dataset(Layout_FL_Non_Profit_Corp_In) pInputfile) :=
function

	f := pInputfile;
	r := govdata.Layout_FL_Non_Profit_Corp_In;

	getBestRank(STRING s) := MAP(StringLib.StringContains(s, 'D', TRUE) => 'DIRECTOR',
								 StringLib.StringContains(s, 'P', TRUE) => 'PRESIDENT',
								 StringLib.StringContains(s, 'V', TRUE) => 'VICE PRESIDENT',
								 StringLib.StringContains(s, 'C', TRUE) => 'CHAIRMAN',
								 StringLib.StringContains(s, 'T', TRUE) => 'TREASURER',
								 StringLib.StringContains(s, 'S', TRUE) => 'SECRETARY',
								 '');

	// output(choosen(govdata.File_FL_Non_Profit_Corp_In, 100));
	// Modified code to fix the dates that were wrongly parsed as per 
	// JIRA DF-20838 Incorrect Date Last Seen in FL FBN Record in old Business Header BDID 48554866
	MMDDYYYY_2_YYYYMMDD(STRING8 s) := (INTEGER)(s[5..8] + s[1..2] + s[3..4]);
	firstDate(r file) := ut.Min2(ut.Min2(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_1), 
																			 MMDDYYYY_2_YYYYMMDD(file.annual_report_date_2)),
															 ut.Min2(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_3),
																			 MMDDYYYY_2_YYYYMMDD(file.annual_cor_file_date)));
	lastDate(r file)  := Max(Max(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_1), 
															 MMDDYYYY_2_YYYYMMDD(file.annual_report_date_2)),
													 Max(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_3),
															 MMDDYYYY_2_YYYYMMDD(file.annual_last_trx_date))); 

	Business_Header.Layout_Business_Contact_Full_New cleaner(f L, INTEGER C) :=
	TRANSFORM
		// General Record Data
		temp_firstdate := intformat(firstDate(L),8,1);
		temp_lastdate := intformat(lastDate(L),8,1);
		SELF.bdid := 0;
		SELF.did := 0;
		SELF.vl_id := L.annual_cor_number;
		SELF.vendor_id := L.annual_cor_number;
		SELF.dt_first_seen := if (_validate.date.fIsValid(temp_firstdate) and 
															_validate.date.fIsValid(temp_firstdate,_validate.date.rules.DateInPast), firstDate(L),0);
		SELF.dt_last_seen := if (_validate.date.fIsValid(temp_lastdate) and 
														 _validate.date.fIsValid(temp_lastdate,_validate.date.rules.DateInPast), lastDate(L),0);
		SELF.source := MDR.sourceTools.src_FL_Non_Profit;
		SELF.record_type := 'C';
		// Person Data
		SELF.company_title := CHOOSE(C, getBestRank(L.ANNUAL_PRINC_TITLE_1), getBestRank(L.ANNUAL_PRINC_TITLE_2),
										getBestRank(L.ANNUAL_PRINC_TITLE_3), getBestRank(L.ANNUAL_PRINC_TITLE_4),
										getBestRank(L.ANNUAL_PRINC_TITLE_5), getBestRank(L.ANNUAL_PRINC_TITLE_6));
		SELF.title := CHOOSE(C, L.princ1_title, L.princ2_title, L.princ3_title, 
								L.princ4_title, L.princ5_title, L.princ6_title);
		SELF.fname := CHOOSE(C, L.princ1_fname, L.princ2_fname, L.princ3_fname, 
										L.princ4_fname, L.princ5_fname, L.princ6_fname);
		SELF.mname := CHOOSE(C, L.princ1_mname, L.princ2_mname, L.princ3_mname, 
										L.princ4_mname, L.princ5_mname, L.princ6_mname);
		SELF.lname := CHOOSE(C, L.princ1_lname, L.princ2_lname, L.princ3_lname, 
										L.princ4_lname, L.princ5_lname, L.princ6_lname);
		SELF.name_suffix := CHOOSE(C, L.princ1_name_suffix, L.princ2_name_suffix, L.princ3_name_suffix, 
											L.princ4_name_suffix, L.princ5_name_suffix, L.princ6_name_suffix);
		SELF.name_score := CHOOSE(C, L.princ1_name_score, L.princ2_name_score, L.princ3_name_score, 
											L.princ4_name_score, L.princ5_name_score, L.princ6_name_score);
		SELF.prim_range := CHOOSE(C, L.princ1_prim_range, L.princ2_prim_range, L.princ3_prim_range, 
											L.princ4_prim_range, L.princ5_prim_range, L.princ6_prim_range);
		SELF.predir := CHOOSE(C, L.princ1_predir, L.princ2_predir, L.princ3_predir, 
										L.princ4_predir, L.princ5_predir, L.princ6_predir);
		SELF.prim_name := CHOOSE(C, L.princ1_prim_name, L.princ2_prim_name, L.princ3_prim_name,
											L.princ4_prim_name, L.princ5_prim_name, L.princ6_prim_name);
		SELF.addr_suffix := CHOOSE(C, L.princ1_addr_suffix, L.princ2_addr_suffix, L.princ3_addr_suffix, 
											L.princ4_addr_suffix, L.princ5_addr_suffix, L.princ6_addr_suffix);
		SELF.postdir := CHOOSE(C, L.princ1_postdir, L.princ2_postdir, L.princ3_postdir,
											L.princ4_postdir, L.princ5_postdir, L.princ6_postdir);
		SELF.unit_desig := CHOOSE(C, L.princ1_unit_desig, L.princ2_unit_desig, L.princ3_unit_desig, 
											L.princ4_unit_desig, L.princ5_unit_desig, L.princ6_unit_desig);
		SELF.sec_range := CHOOSE(C, L.princ1_sec_range, L.princ2_sec_range, L.princ3_sec_range, 
											L.princ4_sec_range, L.princ5_sec_range, L.princ6_sec_range);
		SELF.city := CHOOSE(C, L.princ1_v_city_name, L.princ2_v_city_name, L.princ3_v_city_name, 
									L.princ4_v_city_name, L.princ5_v_city_name, L.princ6_v_city_name);
		SELF.state := CHOOSE(C, L.princ1_st, L.princ2_st, L.princ3_st, 
										L.princ4_st, L.princ5_st, L.princ6_st);
		SELF.zip := (INTEGER) CHOOSE(C, L.princ1_zip, L.princ2_zip, L.princ3_zip, 
										L.princ4_zip, L.princ5_zip, L.princ6_zip);
		SELF.zip4 := (INTEGER) CHOOSE(C, L.princ1_zip4, L.princ2_zip4, L.princ3_zip4, 
										 L.princ4_zip4, L.princ5_zip4, L.princ6_zip4);
		SELF.county := CHOOSE(C, L.princ1_county[3..5], L.princ2_county[3..5], L.princ3_county[3..5], 
										L.princ4_county[3..5], L.princ5_county[3..5], L.princ6_county[3..5]);
		SELF.msa := CHOOSE(C, L.princ1_msa, L.princ2_msa, L.princ3_msa, 
									L.princ4_msa, L.princ5_msa, L.princ6_msa);
		SELF.geo_lat := CHOOSE(C, L.princ1_geo_lat, L.princ2_geo_lat, L.princ3_geo_lat, 
										L.princ4_geo_lat, L.princ5_geo_lat, L.princ6_geo_lat);
		SELF.geo_long := CHOOSE(C, L.princ1_geo_long, L.princ2_geo_long, L.princ3_geo_long, 
										L.princ4_geo_long, L.princ5_geo_long, L.princ6_geo_long);
		SELF.phone := 0;
		SELF.email_address := '';
		SELF.ssn := 0;
		// Company Data
		SELF.company_source_group := '';
		SELF.company_name := L.ANNUAL_COR_NAME;
		SELF.company_prim_range := L.corp_prim_range;
		SELF.company_predir := L.corp_predir;
		SELF.company_prim_name := L.corp_prim_name;
		SELF.company_addr_suffix := L.corp_addr_suffix;
		SELF.company_postdir := L.corp_postdir;
		SELF.company_unit_desig := L.corp_unit_desig;
		SELF.company_sec_range := L.corp_sec_range;
		SELF.company_city := L.corp_v_city_name;
		SELF.company_state := L.corp_st;
		SELF.company_zip := (INTEGER)L.corp_zip;
		SELF.company_zip4 := (INTEGER)L.corp_zip4;
		SELF.company_phone := 0;
		SELF.company_fein := (INTEGER)L.ANNUAL_COR_FEI_NUMBER;
	END;
	cleanedCO := NORMALIZE(f, 6, cleaner(LEFT, COUNTER));

	Business_Header.Layout_Business_Contact_Full_New cleaner2(f L) :=
	TRANSFORM
		// General Record Data
		SELF.bdid := 0;
		SELF.did := 0;
		SELF.vl_id := L.annual_cor_number;
		SELF.vendor_id := L.annual_cor_number;
		SELF.dt_first_seen := firstDate(L);
		SELF.dt_last_seen := lastDate(L);
		SELF.source := MDR.sourceTools.src_FL_Non_Profit;
		SELF.record_type := 'C';  
		//Person Data
		SELF.company_title := 'REGISTERED AGENT';
		SELF.title := L.ra_title;
		SELF.fname := L.ra_fname;
		SELF.mname := L.ra_mname;
		SELF.lname := L.ra_lname;
		SELF.name_suffix := L.ra_name_suffix;
		SELF.name_score := L.ra_name_score;
		SELF.prim_range := L.ra_prim_range;
		SELF.predir := L.ra_predir;
		SELF.prim_name := L.ra_prim_name;
		SELF.addr_suffix := L.ra_addr_suffix;
		SELF.postdir := L.ra_postdir;
		SELF.unit_desig := L.ra_unit_desig;
		SELF.sec_range := L.ra_sec_range;
		SELF.city := L.ra_v_city_name;
		SELF.state := L.ra_st;
		SELF.zip := (INTEGER)L.ra_zip;
		SELF.zip4 := (INTEGER)L.ra_zip4;
		SELF.county := L.ra_county[3..5];
		SELF.msa := L.ra_msa;
		SELF.geo_lat := L.ra_geo_lat;
		SELF.geo_long := L.ra_geo_long;
		SELF.phone := 0;
		SELF.email_address := '';
		SELF.ssn := 0;
		// Company Data
		SELF.company_source_group := '';
		SELF.company_name := L.ANNUAL_COR_NAME;
		SELF.company_prim_range := L.corp_prim_range;
		SELF.company_predir := L.corp_predir;
		SELF.company_prim_name := L.corp_prim_name;
		SELF.company_addr_suffix := L.corp_addr_suffix;
		SELF.company_postdir := L.corp_postdir;
		SELF.company_unit_desig := L.corp_unit_desig;
		SELF.company_sec_range := L.corp_sec_range;
		SELF.company_city := L.corp_v_city_name;
		SELF.company_state := L.corp_st;
		SELF.company_zip := (INTEGER)L.corp_zip;
		SELF.company_zip4 := (INTEGER)L.corp_zip4;
		SELF.company_phone := 0;
		SELF.company_fein := (INTEGER)L.ANNUAL_COR_FEI_NUMBER;
	END;
	AgentsAsCO := PROJECT(f((integer)(datalib.NameClean(annual_ra_name)[142]) < 3), cleaner2(LEFT));
							
	allCompanies := (cleanedCO + AgentsAsCO)(lname <> '');

	return allCompanies;

end;
