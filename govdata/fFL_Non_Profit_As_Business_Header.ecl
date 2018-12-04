import ut, Business_Header, mdr, _validate;

export fFL_Non_Profit_As_Business_Header(dataset(Layout_FL_Non_Profit_Corp_In) pInputfile) :=
function

	f := pInputfile;
	r := govdata.Layout_FL_Non_Profit_Corp_In;

	// output(choosen(govdata.File_FL_Non_Profit_Corp_In, 100));
	// Modified code to fix the dates that were wrongly parsed as per 
	// JIRA DF-20838 Incorrect Date Last Seen in FL FBN Record in old Business Header BDID 48554866
	MMDDYYYY_2_YYYYMMDD(STRING8 s) := (INTEGER)(s[5..8] + s[1..2] + s[3..4]);
	firstDate(f file) := ut.Min2(ut.Min2(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_1), 
																			 MMDDYYYY_2_YYYYMMDD(file.annual_report_date_2)),
															 ut.Min2(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_3),
																			 MMDDYYYY_2_YYYYMMDD(file.annual_cor_file_date)));
	lastDate(f file)  := Max(Max(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_1), 
															 MMDDYYYY_2_YYYYMMDD(file.annual_report_date_2)),
													 Max(MMDDYYYY_2_YYYYMMDD(file.annual_report_date_3),
															 MMDDYYYY_2_YYYYMMDD(file.annual_last_trx_date))); 

	Business_Header.Layout_Business_Header_New cleaner(f L) :=
	TRANSFORM
		temp_firstdate := intformat(firstDate(L),8,1);
		temp_lastdate := intformat(lastDate(L),8,1);
	  SELF.rcid := 0;
	  SELF.bdid := 0;
	  SELF.source := MDR.sourceTools.src_FL_Non_Profit;
	  SELF.source_group := '';
	  SELF.pflag := ''; 
	  SELF.group1_id := 0;
		SELF.vl_id := L.annual_cor_number;
	  SELF.vendor_id := L.annual_cor_number;
		
	  SELF.dt_first_seen := if (_validate.date.fIsValid(temp_firstdate) and 
															_validate.date.fIsValid(temp_firstdate,_validate.date.rules.DateInPast), firstDate(L),0);
	  SELF.dt_last_seen := if (_validate.date.fIsValid(temp_lastdate) and 
														 _validate.date.fIsValid(temp_lastdate,_validate.date.rules.DateInPast), lastDate(L),0);
	  SELF.dt_vendor_first_reported := if (_validate.date.fIsValid(temp_firstdate) and 
																				 _validate.date.fIsValid(temp_firstdate,_validate.date.rules.DateInPast), firstDate(L),0);
	  SELF.dt_vendor_last_reported := if (_validate.date.fIsValid(temp_lastdate) and 
																				_validate.date.fIsValid(temp_lastdate,_validate.date.rules.DateInPast), lastDate(L),0);
	  SELF.company_name := L.ANNUAL_COR_NAME;
	  SELF.prim_range := L.corp_prim_range;
	  SELF.predir := L.corp_predir;
	  SELF.prim_name := L.corp_prim_name;
	  SELF.addr_suffix := L.corp_addr_suffix;
	  SELF.postdir := L.corp_postdir;
	  SELF.unit_desig := L.corp_unit_desig;
	  SELF.sec_range := L.corp_sec_range;
	  SELF.city := L.corp_v_city_name;
	  SELF.state := L.corp_st;
	  SELF.zip := (INTEGER)L.corp_zip;
	  SELF.zip4 := (INTEGER)L.corp_zip4;
	  SELF.county := L.corp_county[3..5];
	  SELF.msa := L.corp_msa;
	  SELF.geo_lat := L.corp_geo_lat;
	  SELF.geo_long := L.corp_geo_long;
	  SELF.phone := 0;
	  SELF.phone_score := 0;
	  SELF.fein := (INTEGER)L.ANNUAL_COR_FEI_NUMBER;
	  SELF.current := TRUE;
	END;
	cleanedCO := PROJECT(f, cleaner(LEFT));


	Business_Header.Layout_Business_Header_New cleaner2(f L) :=
	TRANSFORM
	  SELF.rcid := 0;			
	  SELF.bdid := 0;			
	  SELF.source := MDR.sourceTools.src_FL_Non_Profit;			
	  SELF.source_group := '';
	  SELF.pflag := ''; 
	  SELF.group1_id := 0;
		SELF.vl_id := L.annual_cor_number;
	  SELF.vendor_id := L.annual_cor_number;
	  SELF.dt_first_seen := firstDate(L);
	  SELF.dt_last_seen := lastDate(L);
	  SELF.dt_vendor_first_reported := firstDate(L);
	  SELF.dt_vendor_last_reported := lastDate(L);
	  SELF.company_name := L.annual_ra_name;
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
	  SELF.phone_score := 0;
	  SELF.fein := 0;
	  SELF.current := TRUE;
	END;
	AgentsAsCO := PROJECT(f(ANNUAL_RA_NAME_TYPE = 'C' AND
							datalib.CompanyClean(ANNUAL_RA_NAME)[41..120] != ''), cleaner2(LEFT));
							
	allCompanies := (cleanedCO + AgentsAsCO)(company_name <> '');

	return allCompanies;

end;