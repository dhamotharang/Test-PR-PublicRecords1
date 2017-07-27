import ut, Business_Header;

f := govdata.File_FL_Non_Profit_Corp_In;
r := govdata.Layout_FL_Non_Profit_Corp_In;

// output(choosen(govdata.File_FL_Non_Profit_Corp_In, 100));
DDMMYYYY_2_YYYYMMDD(STRING8 s) := (INTEGER)(s[5..8] + s[3..4] + s[1..2]);
firstDate(f file) := ut.Min2(
					 ut.Min2(DDMMYYYY_2_YYYYMMDD(file.annual_report_date_1), 
							 DDMMYYYY_2_YYYYMMDD(file.annual_report_date_2)),
					 ut.Min2(DDMMYYYY_2_YYYYMMDD(file.annual_report_date_3),
							 DDMMYYYY_2_YYYYMMDD(file.annual_cor_file_date)));
lastDate(f file)  := ut.Max2(
					 ut.Max2(DDMMYYYY_2_YYYYMMDD(file.annual_report_date_1), 
							 DDMMYYYY_2_YYYYMMDD(file.annual_report_date_2)),
					 ut.Max2(DDMMYYYY_2_YYYYMMDD(file.annual_report_date_3),
							 DDMMYYYY_2_YYYYMMDD(file.annual_last_trx_date))); 

Business_Header.Layout_Business_Header cleaner(f L) :=
TRANSFORM
  SELF.rcid := 0;
  SELF.bdid := 0;
  SELF.source := 'FN';
  SELF.source_group := '';
  SELF.pflag := ''; 
  SELF.group1_id := 0;
  SELF.vendor_id := L.annual_cor_number;
  SELF.dt_first_seen := firstDate(L);
  SELF.dt_last_seen := lastDate(L);
  SELF.dt_vendor_first_reported := firstDate(L);
  SELF.dt_vendor_last_reported := lastDate(L);
  SELF.company_name := L.ANNUAL_COR_NAME;
  SELF.prim_range := L.corp_prim_range;
  SELF.predir := L.corp_predir;
  SELF.prim_name := L.corp_prim_name;
  SELF.addr_suffix := L.corp_addr_suffix;
  SELF.postdir := L.corp_postdir;
  SELF.unit_desig := L.corp_unit_desig;
  SELF.sec_range := L.corp_sec_range;
  SELF.city := L.corp_p_city_name;
  SELF.state := L.corp_st;
  SELF.zip := (INTEGER)L.corp_zip;
  SELF.zip4 := (INTEGER)L.corp_zip4;
  SELF.county := L.corp_county;
  SELF.msa := L.corp_msa;
  SELF.geo_lat := L.corp_geo_lat;
  SELF.geo_long := L.corp_geo_long;
  SELF.phone := 0;
  SELF.phone_score := 0;
  SELF.fein := (INTEGER)L.ANNUAL_COR_FEI_NUMBER;
  SELF.current := TRUE;
END;
cleanedCO := PROJECT(f, cleaner(LEFT));


Business_Header.Layout_Business_Header cleaner2(f L) :=
TRANSFORM
  SELF.rcid := 0;			
  SELF.bdid := 0;			
  SELF.source := 'FN';			
  SELF.source_group := '';
  SELF.pflag := ''; 
  SELF.group1_id := 0;
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
  SELF.city := L.ra_p_city_name;
  SELF.state := L.ra_st;
  SELF.zip := (INTEGER)L.ra_zip;
  SELF.zip4 := (INTEGER)L.ra_zip4;
  SELF.county := L.ra_county;
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

export FL_Non_Profit_As_Business_Header := allCompanies;