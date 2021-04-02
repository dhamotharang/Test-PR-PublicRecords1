//property standardized land use
// Prod
//original code pulled from W20190211-124931-dataland, that code only pulled records from the 'monthly' file; it did not include the 'fast' file

IMPORT _Control, data_services, LN_PropertyV2, LN_PropertyV2_Fast, STD, ut;
export NonFCRA_Property_Tax_By_LandUse(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function 

filedate := today;

tax_key1 := PULL(LN_PropertyV2.key_assessor_fid(false));
tax_key2 := PULL(LN_PropertyV2_Fast.key_assessor_fid(false,true));
Key_Tax_Non_FCRA_monthly := tax_key1 + tax_key2;

rSource := RECORD
		string source_val;
		string which_prop_file;
		Key_Tax_Non_FCRA_monthly;
	END;

rSource TwoSourcesMonthly(Key_Tax_Non_FCRA_monthly pInput) := TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  
		SELF.which_prop_file := 'TAX-MONTHLY';
		SELF := pInput;
	END;

Key_Tax_Non_FCRA_monthly_plus_2010 := PROJECT(Key_Tax_Non_FCRA_monthly((proc_date between 201001 and (unsigned6) filedate[1..6]), state_code <> ''), TwoSourcesMonthly(LEFT));
//output(Key_Tax_Non_FCRA_monthly_plus_2010(standardized_land_use_code[1] = '9'));

//tbl_Key_Tax_Non_FCRA_monthly_2010_use := TABLE(Key_Tax_Non_FCRA_monthly_plus_2010, {standardized_land_use_code, record_count := count(group)}, standardized_land_use_code, few);
//output(sort(tbl_Key_Tax_Non_FCRA_monthly_2010_use, standardized_land_use_code), ALL);

//Key_Tax_Non_FCRA_2010_props := DEDUP(sort(distribute(Key_Tax_Non_FCRA_monthly_plus_2010, hash(source_val, proc_date,state_code, fips_code,fares_unformatted_apn)), source_val, proc_date,state_code, fips_code,fares_unformatted_apn,standardized_land_use_code, local), proc_date,state_code, fips_code,fares_unformatted_apn,standardized_land_use_code, local);
Key_Tax_Non_FCRA_2010_props_srcA := DEDUP(sort(distribute(Key_Tax_Non_FCRA_monthly_plus_2010(source_val = 'Source A' AND fares_unformatted_apn <> ''), hash(proc_date,state_code, fips_code,fares_unformatted_apn)), proc_date,state_code, fips_code,fares_unformatted_apn,standardized_land_use_code, local), proc_date,state_code, fips_code,fares_unformatted_apn,standardized_land_use_code, local);
Key_Tax_Non_FCRA_2010_props_srcB := DEDUP(sort(distribute(Key_Tax_Non_FCRA_monthly_plus_2010(source_val = 'Source B' AND fares_unformatted_apn <> ''), hash(proc_date,state_code, fips_code,fares_unformatted_apn)), proc_date,state_code, fips_code,fares_unformatted_apn,standardized_land_use_code, local), proc_date,state_code, fips_code,fares_unformatted_apn,standardized_land_use_code, local);

//proc_date is YYYYMM from the value for Recording Date, which is when the transaction was filed at the county
tbl_Key_Tax_Non_FCRA_2010_props_srcA := TABLE(Key_Tax_Non_FCRA_2010_props_srcA, {source_val, proc_date, state_code, standardized_land_use_code, standardized_land_use := DI_Metrics.fnPropertyStandardizedLandUseDesc('Source A',standardized_land_use_code), property_count := count(group)}, source_val, proc_date, state_code, standardized_land_use_code, MANY);
tbl_Key_Tax_Non_FCRA_2010_props_srcB := TABLE(Key_Tax_Non_FCRA_2010_props_srcB, {source_val, proc_date, state_code, standardized_land_use_code, standardized_land_use := DI_Metrics.fnPropertyStandardizedLandUseDesc('Source B',standardized_land_use_code), property_count := count(group)}, source_val, proc_date, state_code, standardized_land_use_code, MANY);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
tbl_Non_FCRA_props_srcA := STD.File.Despray('~thor_data400::data_insight::data_metrics::tbl_Key_Tax_Non_FCRA_2010_properties_by_StandLandUse_SrcA_'+ filedate +'.csv',
																						pHostname, 
																						pTarget + '/tbl_Key_Tax_Non_FCRA_2010_properties_by_StandLandUse_SrcA_'+ filedate +'.csv'
																						,,,,true);
																									
tbl_Non_FCRA_props_srcB := STD.File.Despray('~thor_data400::data_insight::data_metrics::tbl_Key_Tax_Non_FCRA_2010_properties_by_StandLandUse_SrcB_'+ filedate  +'.csv',
																						pHostname, 
																						pTarget + '/tbl_Key_Tax_Non_FCRA_2010_properties_by_StandLandUse_SrcB_'+ filedate +'.csv'
																						,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_Key_Tax_Non_FCRA_2010_props_srcA, source_val, proc_date,state_code, standardized_land_use_code, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_Tax_Non_FCRA_2010_properties_by_StandLandUse_SrcA_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_Key_Tax_Non_FCRA_2010_props_srcB, source_val, proc_date,state_code, standardized_land_use_code, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_Tax_Non_FCRA_2010_properties_by_StandLandUse_SrcB_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,tbl_Non_FCRA_props_srcA  
					,tbl_Non_FCRA_props_srcB):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Property_Tax_By_LandUse Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Property_Tax_By_LandUse Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
					);
return email_alert;

end;